# twail

`twail` is inspired by the venerable Unix `tail` program.  `twail` lets
you tail your Twitter timelines, or run a twitter search.  

![screenshot](https://github.com/danchoi/twail/raw/master/screenshot.png)

## Installation

    gem install twail

## Setup

Before using twail, you must first get a Twitter API key and authorize
the `twurl` command (note that this is a different command from `twail`)
to access your Twitter account. Type 

    twurl -T

for instructions.

## Usage

    twail [timeline]

    or 

    twail s [search args]

## Tailing your timelines 

The timeline output looks like this:

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

In timeline mode, `twail` works like `tail -f`.  It will print tweets out as
they appear in the specified timeline.  You can redirect the output however you
want.  One pipeline I like to use is

    twail home | tee -a twitter.home.log

Lots of other pipelines are possible.  Knock yourself out.  To stop
`twail`, press `CTRL-C`.


## Search for tweets

You can run a Twitter search with `twail s [search args]`.

Search arguments are simply the words you want to submit as your Twitter search
query.

`twail` will print each of search results as it fetches them and keep going
backward in time until the results are exhausted.

The output of `twail` in search mode looks like this:

    $ twail s vitunes itunes
    2011-08-02 20:38:03 |      garry_stewart | Via @otaku_jstewart: http://bit.ly/rgfaKw &lt;-- ViTunes: Controlling iTunes from vi/vim
    2011-08-02 20:16:29 |              xshay | RT @notahat: If you feel that you don't have enough nerd cred, try driving iTunes from Vim: http://t.co/hFkolMZ
    2011-08-02 20:00:08 |           rubygems | vitunes (0.4.6): http://is.gd/1JmVwn Control iTunes with Vim
    2011-08-02 19:54:08 |          priyaaank | iTune from vi! Every vi lover's dream. :) http://danielchoi.com/software/vitunes.html
    2011-08-02 19:50:02 |               k_ui | Vim で動く iTunes クローンらしい &gt; ViTunes http://bit.ly/o9FGap
    2011-08-02 19:47:50 |         hongymagic | RT @jadzor: ViTunes. Yeah, that's right. http://t.co/ZZkIk2T
    2011-08-02 19:34:33 |       lindsayevans | RT @jadzor: ViTunes. Yeah, that's right. http://t.co/ZZkIk2T
    2011-08-02 19:31:22 |             jadzor | ViTunes. Yeah, that's right. http://t.co/ZZkIk2T
    2011-08-02 19:25:13 |          david2777 | Hahaha ViTunes http://t.co/xaGEOli
    2011-08-02 19:11:51 |            notahat | If you feel that you don't have enough nerd cred, try driving iTunes from Vim: http://t.co/hFkolMZ
    2011-08-02 18:58:38 |            rnewman | RT @boingr: controlling iTunes in vim with http://danielchoi.com/software/vitunes.html
    2011-08-02 18:56:30 |           benbelly | For you @edgauthier RT @newsycombinator ViTunes http://j.mp/lSDlBt
    2011-08-02 18:50:18 |         pelayo1974 | Applesfera - ViTunes, controla iTunes desde el Terminal http://www.applesfera.com/curiosidades/vitunes-controla-itunes-desde-el-terminal
    2011-08-02 18:43:28 |              frigo | RT @msutherl: omg awesome, ViTunes: control iTunes from Vim: http://t.co/iheGoIA
    2011-08-02 18:39:10 |         SinnerBOFH | #BOFHers #vim RT @tatai: Igual empiezo a usar iTunes entonces ;) RT @elorz007: @tatai Interfaz de iTunes para vi http://bit.ly/ope5Q7
    2011-08-02 18:19:00 |            bgarber | RT @otaviocc: VIM + iTunes = ViTunes http://j.mp/lSDlBt
    2011-08-02 18:17:51 |             geyson | RT @otaviocc: VIM + iTunes = ViTunes http://j.mp/lSDlBt
    2011-08-02 18:04:30 |             apoena | &quot;@otaviocc: VIM + iTunes = ViTunes http://t.co/CBkWJ6t&quot; isso é oldschool.vou testar hoje.hehe
    2011-08-02 17:47:13 |           otaviocc | VIM + iTunes = ViTunes http://j.mp/lSDlBt
    2011-08-02 17:44:35 |           spdalton | @danchoi vitunes is amazing. Thank you!
    2011-08-02 17:41:21 |         felipebrnd | +1 membro! @taverneiro Wow! RT @newsycombinator ViTunes http://t.co/zeqqMx0
    2011-08-02 17:39:59 |               3kwa | @knotty can you control iTunes from XCode? http://bit.ly/kdRLNG :D
    2011-08-02 17:38:54 |           spdalton | This is why I use Vim. (via http://t.co/sbqWJ8c) http://t.co/WgH6DGT
    2011-08-02 17:29:43 |            ggarron | vitunes http://t.co/dqC1sdq #mac
    etc.


## About

If you like `twail` and you're a Vim user, try [twim][twim].

[twim]:https://github.com/danchoi/twim

`twail` was created by Daniel Choi.  It's really just a convenience
wrapper around the awesome [twurl][twurl] program.

[twurl]:https://github.com/marcel/twurl

You can follow me on Twitter at <http://twitter.com/danchoi>.


