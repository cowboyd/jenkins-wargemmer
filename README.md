## Hudson Wargemmer

#### What?

The hudson wargemmer consists of two parts: a Rake task for turning a hudson war file
(__W.__eb __A.__ __R.__chive for those not familiar with java lingo) into a distributable rubygem, and a cron task for creating
a new version of the gem, whenever a new hudson version comes out.

The script polls the hudson update center and checks to see if there is a newer version of the hudson distribution that
has not yet been gemmed up and if not, then bundles it and pushes it to [rubygems.org](http://rubygems.org) as a gem named
hudson-war.

The generated gem has the same version number as the hudson distribution itself. So if you want the 1.386 distribution, then you would do a

    gem install hudson-war --version 1.386

#### How?

In addition to the war file  long with the The hudson-war gem comes with an executable script `hudson.war` to help you leverage your hudson distribution. 

Without any arguments, it returns the location of the hudson warfile itself:

    $ hudson.war location
    /Users/cowboyd/.rvm/gems/ruby-1.8.7-p174@hudson.war/gems/hudson-war-1.391/lib/hudson/hudson.war

It can unpack itself to a given directory. This is useful if you want to extract certain assets such as classfiles, annotations, configurations from it.

    $ hudson.war unpack /tmp/hudson.war.exploded
    
It can copy itself anywhere

    $ hudson.war cp tmp
    copied /Users/cowboyd/.rvm/gems/ruby-1.8.7-p174@hudson.war/gems/hudson-war-1.391/lib/hudson/hudson.war -> tmp

Or if you want the classpath:

    $ hudson.war classpath
    /Users/cowboyd/.hudson/wars/1.391/WEB-INF/lib/hudson-core-1.391.jar

You can even run a test server with your shiny hudson war file.

    $ hudson.war server

All of these functions can be accessed from ruby code via the `Hudson::War` module.




