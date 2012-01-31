#!/usr/bin/env ruby
# encoding: UTF-8
require 'json'
require 'yaml'
require 'twurl'
require 'time'
require 'optparse'


# TODO DRY this code up!

TIMELINES = %w( public home friends user)
SPECIAL = %w(mentions retweeted_by_me retweeted_to_me retweets_of_me)

if %w(-h --help).include?(ARGV.first)
  puts <<END

Before using twail, you must first get a Twitter API key and authorize the twurl
command to access your Twitter account. Type 

    twurl -T

for instructions.

Assuming you've done that, read on.

Usage: twail [timeline]
        
       twail s [max pages] [search args]

[timeline] can be any of these:

    public 
    home 
    friends 
    user 
    mentions 
    retweeted_by_me 
    retweeted_to_me 
    retweets_of_me

"home" is the default.

You can use these abbreviations: 

    p h f u m by to of

twail will perform a Twitter search if you use 

    twail s [search args]

To stop returning search results after n pages, use 

    twail s [n] [search args]

To include tweet ids, use the -i flag:

    twail -i s [n] [search args]

To automatically wrap long text, use the -w flag:

    twail -w m

For more help, see the README at 

    https://github.com/danchoi/twail

END
  exit
end

class String
  def wrap(len=65)
    gsub(/\n/, " ").gsub(/.{1,#{len}}(?:\s|\Z)/){$&+"\n"}
  end
end

options = {}
OptionParser.new {|opts|
  opts.on("-w", "--wrap", "Wrap long text") {|x| options[:wrap] = x }
  opts.on("-i", "--include-ids", "Include tweet ids") {|x| options[:tweet_ids] = x }
}.parse!

# search is different
if ARGV.first =~ /^s/ # search
  ARGV.shift
  max_pages = if ARGV[0] =~ /^\d+/ 
                ARGV.shift 
              end
  query = "?q=#{URI.escape(ARGV.join(' '))}"
  if max_pages
    $stderr.puts "Max pages: #{max_pages}"
  end

  total_width = `tput cols`.to_i
  text_width = (total_width - 44) 

  while query 
    begin
      url = "http://search.twitter.com/search.json#{query}"
      json = `curl -s '#{url}'`
      res = JSON.parse(json)
      res['results'].each do |x|
        time = Time.parse(x['created_at']).localtime
        text = x['text'].gsub(/\n/, ' ')
        text += " #{x['id']}" if options[:tweet_ids]
        textlines = options[:wrap] ? text.wrap(text_width).split(/\n/) : [text] 
        puts "%s | %s | %s" % [time.to_s.gsub(/\s\S+$/,''), x['from_user'].rjust(18), textlines.shift]
        textlines.each do |line|
          puts("%s | %s" % [''.rjust(40), line])
        end
      end
      query = res['next_page']
      if max_pages
        if query.nil? || query[/page=(\d+)/, 1].to_i > max_pages.to_i
          exit
        end
      end
    rescue Errno::EPIPE
      exit
    end
  end
  exit 
end

# timeline tail
timeline = if ARGV.first 
             (TIMELINES + SPECIAL).detect {|t| 
               t =~ /^#{ARGV.first}/ || ((t =~ /_/) && (t.split('_')[1]  =~ /^#{ARGV.first}/)) 
             } 
           else
             'home'
           end
puts "Logging #{timeline} timeline at #{Time.now}"
url = case timeline
      when 'retweets_of_me'
        # This doesn't seem to do anything different; figure out later
        "/1/statuses/#{timeline}.json?include_entities=true"
      when *SPECIAL
        "/1/statuses/#{timeline}.json"
      else 
        "/1/statuses/#{timeline}_timeline.json"
      end


trap("INT") { 
  xs = ['Goodbye.', 'Farewell.', 'Have a nice day.', 
    'Now go enjoy the weather!', 'Live long and prosper.', 
    'May the force be with you.']
  $stderr.puts xs[rand(xs.size)]
  exit
}

seen = []
network = true
total_width = `tput cols`.to_i

loop do 
  raw = begin 
          Twurl::CLI.output = StringIO.new
          Twurl::CLI.run([url]) 
          if network == false
            network = true
            $stderr.print(" The network is back up!\n")
          end
          Twurl::CLI.output.read
          Twurl::CLI.output.rewind
          Twurl::CLI.output.read
        rescue SocketError 
          if network
            $stderr.print("The network seems to be down.") 
          else
            $stderr.print('.')
          end
          network = false
          sleep 20
          next 
        end
  res = JSON.parse(raw).reverse
  res.each do |x|
    next if seen.include?(x['id'])
    seen << x['id']
    text = x['text'].gsub(/\n/, ' ')
    text += " #{x['id']}" if options[:tweet_ids]
    user_width = 18
    from = x['user']['screen_name'][0,user_width]
    text_width = (total_width - user_width) - 3
    textlines = options[:wrap] ? text.wrap(text_width).split(/\n/) : [text] 

    puts("%s| %s" % [from.rjust(user_width), textlines.shift])
    textlines.each do |line|
      puts("%s| %s" % [''.rjust(user_width), line])
    end
  end
  if !$stdout.tty?
    $stdout.flush
    exit
  end
  sleep 30
end

