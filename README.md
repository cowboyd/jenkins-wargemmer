## Jenkins Wargemmer

#### What?

The jenkins wargemmer consists of two parts: a Rake task for turning a jenkins war file
(__W.__eb __A.__ __R.__chive for those not familiar with java lingo) into a distributable rubygem, and a cron task for creating
a new version of the gem, whenever a new jenkins version comes out.

The script polls the jenkins update center and checks to see if there is a newer version of the jenkins distribution that
has not yet been gemmed up and if not, then bundles it and pushes it to [rubygems.org](http://rubygems.org) as a gem named
jenkins-war.

The generated gem has the same version number as the jenkins distribution itself. So if you want the 1.386 distribution, then you would do a

    gem install jenkins-war --version 1.386

#### How?

In addition to the war file  long with the The jenkins-war gem comes with an executable script `jenkins.war` to help you leverage your jenkins distribution. 

Without any arguments, it returns the location of the jenkins warfile itself:

    $ jenkins.war location
    /Users/cowboyd/.rvm/gems/ruby-1.8.7-p174@jenkins.war/gems/jenkins-war-1.391/lib/jenkins/jenkins.war

It can unpack itself to a given directory. This is useful if you want to extract certain assets such as classfiles, annotations, configurations from it.

    $ jenkins.war unpack /tmp/jenkins.war.exploded
    
It can copy itself anywhere

    $ jenkins.war cp tmp
    copied /Users/cowboyd/.rvm/gems/ruby-1.8.7-p174@jenkins.war/gems/jenkins-war-1.391/lib/jenkins/jenkins.war -> tmp

Or if you want the classpath:

    $ jenkins.war classpath
    /Users/cowboyd/.jenkins/wars/1.391/WEB-INF/lib/jenkins-core-1.391.jar

You can even run a test server with your shiny jenkins war file.

    $ jenkins.war server

All of these functions can be accessed from ruby code via the `Jenkins::War` module.




