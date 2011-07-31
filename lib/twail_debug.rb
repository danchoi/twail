#!/usr/bin/env ruby
# encoding: UTF-8
require 'json'
require 'yaml'
require 'twurl'
require 'pp'

TIMELINES = %w( public home friends user)
SPECIAL = %w(mentions retweeted_by_me retweeted_to_me retweets_of_me)

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
      end
res = JSON.parse(raw).reverse
pp res


