# twail

`twail` is inspired by the venerable Unix `tail` program.  `twail` tails
your Twitter timelines.  

Before using twail, you must first get a Twitter API key and authorize the twurl
command to access your Twitter account. Type 

    twurl -T

for instructions.

Assuming you've done that, read on.

Usage: twail [timeline]

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


`twail` works like `tail -f`.  It will print tweets out as they appear
in the specified timeline.  You can redirect the output however you
want.  One pipeline I like to use is

    twail home | tee -a twitter.home.log

Lots of other pipelines are possible.  Knock yourself out.

`twail` was created by Daniel Choi.  It's really just a convenience
wrapper around the awesome [twurl][twurl] program.

[twurl]:https://github.com/marcel/twurl

You can follow me on Twitter at <http://twitter.com/danchoi>.


