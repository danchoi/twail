# twail

`twail` is inspired by the venerable Unix `tail` program.  `twail` lets
you tail your Twitter timelines.  

# Installation

    gem install twail

# Setup

Before using twail, you must first get a Twitter API key and authorize the twurl
command to access your Twitter account. Type 

    twurl -T

for instructions.


# Usage

    twail [timeline]

The output looks like this:

    $ twail home
    Logging home timeline at 2011-04-21 11:21:36 -0400
            timoreilly| RT @gumption Americans wildly underestimate income disparity, prefer far greater 
                      | equitability @DanAriely http://bit.ly/gE9v3n
           bcardarella| Amazon is now the single point of failure for the Internet
                   RWW| Visa Launches Real-Time, Location-Based Discounts for Gap Customers 
                      | http://rww.to/eK5q8U
            timoreilly| Oops. Seems to be my morning for botching link shortening. Here's the @oreillymedia 
                      | deal of the day link again http://oreil.ly/dHLKR6
              HNTweets| Hipmunk wants you (to run our Android development): http://bit.ly/h095Yz Comments: 
                      | http://bit.ly/fLOAdO
              HNTweets| CSS3 vs. CSS: A Speed Benchmark: http://bit.ly/gOOxvZ Comments: http://bit.ly/hxbRRi
        BostInnovation| MIT Needs Help Finding Dates, According To DateMySchool.com http://bit.ly/gIkO4K
           fixcongress| RT @AlliGerkman WH may require companies bidding for govt contracts to publicly 
                      | disclose cmpgn donations http://bit.ly/e2pRdA #rootstrikers
              sof_ruby| Ruby / Rails: How to identify if the given day, month, and year, combine a legal 
                      | date ?: Given 3 numbers: DD, MM... http://bit.ly/g54YYs
             jpaynerss| A new photo browsing experience in Google Earth http://goo.gl/fb/miiVE
             jpaynerss| More about Google Earth Builder http://goo.gl/fb/VQN2H
              HNTweets| My National Security Letter Gag Order: http://wapo.st/ep0Sh4 Comments: 
                      | http://bit.ly/eVa9Uv
             jonpierce| Moving #StartupDrinks to CBC to accommodate a larger crowd tomorrow. As @evanish 
                      | says, let's think big! See you there? http://t.co/s2Wlwrf
          elwoodicious| RT @Jwarchol: Sometimes you forget how many different sites you have on EC2. This is 
                      | not one of those times.
            rossnelson| RT @neonarcade: Poke is looking for a PHP/MySQL dev for a short term project in NYC. 
                      | Please RT!
          elwoodicious| RT @ShlomoSwidler: RT @Beaker: deploying instances in 2 availability zones costs 
                      | TWICE as much as doing so in 1, so to minimize cost (vs ...
          nickgrossman| RT @Socrative: Socrative won 1st place at the Harvard Grad School of Education 
                      | Bridge Competition. Thanks to organizers and Gates Founda ...
              HNTweets| Incredible Working Factory Made With Lego Robots: http://bit.ly/g5Fzax Comments: 
                      | http://bit.ly/glzdVa
              HNTweets| AWS Outage Reminds Me Of This: 8 Fallacies of Dist. Computing: http://bit.ly/giUX6M 
                      | Comments: http://bit.ly/dIomon

`[timeline]` can be any of the following:

    public 
    home 
    friends 
    user 
    mentions 
    retweeted_by_me 
    retweeted_to_me 
    retweets_of_me

The `home` timeline is the default.

You can use these abbreviations: 

    p h f u m by to of


`twail` works like `tail -f`.  It will print tweets out as they appear
in the specified timeline.  You can redirect the output however you
want.  One pipeline I like to use is

    twail home | tee -a twitter.home.log

Lots of other pipelines are possible.  Knock yourself out.  To stop
`twail`, press `CTRL-C`.

`twail` was created by Daniel Choi.  It's really just a convenience
wrapper around the awesome [twurl][twurl] program.

[twurl]:https://github.com/marcel/twurl

You can follow me on Twitter at <http://twitter.com/danchoi>.


