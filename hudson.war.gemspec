# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hudson/war/version"

Gem::Specification.new do |s|
  s.name        = "hudson.war"
  s.version     = Hudson::War::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Charles Lowell"]
  s.email       = ["cowboyd@thefrontside.net"]
  s.homepage    = "http://rubygems.org/gems/hudson.war"
  s.summary     = "get a specific hudson version with rubygems"
  s.description = "this installs a known version of hudson. It also comes with a cron task to bundle versions of itself when a new version of hudson comes out"

  s.rubyforge_project = "hudson.war"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
