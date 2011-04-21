#!/usr/bin/env ruby
# encoding: UTF-8
require 'json'
require 'yaml'

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

[timeline] can be any of these

  public 
  home 
  friends 
  user 
  mentions 
  retweeted_by_me 
  retweeted_to_me 
  retweets_of_me

You can abbreviate the name of the timeline to any of these

  p h f u m by to of

END
  exit
end

class String
  def wrap(len=65)
    gsub(/\n/, " ").gsub(/.{1,#{len}}(?:\s|\Z)/){$&+"\n"}
  end
end

timeline = if ARGV.first 
             (TIMELINES + SPECIAL).detect {|t| 
               t =~ /^#{ARGV.first}/ || ((t =~ /_/) && (t.split('_')[1]  =~ /^#{ARGV.first}/)) 
             } 
           else
             'home'
           end
puts "Logging #{timeline} timeline"
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
  puts xs[rand(xs.size)]
  exit
}

seen = []

loop do 
  res = JSON.parse(`twurl #{url}`).reverse
  res.each do |x|
    next if seen.include?(x['id'])
    seen << x['id']
    text = x['text'].gsub(/\n/, ' ')
    user_width = 18
    from = x['user']['screen_name'][0,user_width]
    total_width = `tput cols`.to_i
    text_width = (total_width - user_width) - 3
    textlines = text.wrap(text_width).split(/\n/)
    puts("%s| %s" % [from.rjust(user_width), textlines.shift])
    textlines.each do |line|
    puts("%s| %s" % [''.rjust(user_width), line])
    end
  end
  sleep 30
end

