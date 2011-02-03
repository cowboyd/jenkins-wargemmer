require 'bundler/setup'
require 'erb'

INS = FileList['template/**/*.in']

def render(src, dest, use_binding = binding)
  File.open(dest, "w", File.stat(src).mode) do |output|
    result = ERB.new(File.read(src)).result(use_binding)
    output.write(result)
  end
end

task :gem, :version do |t, options|
  jenkins_version = options.version
  raise "invalid version number: #{options.version}" unless jenkins_version.to_f > 0
  directory gem_dir = "pkg/#{jenkins_version}"
  outs = INS.map do |f|
    filename = File.join(f.split('/')[1..-1])
    directory dest_dir = File.join(gem_dir, File.dirname(filename))
    file(File.join(dest_dir, File.basename(filename, '.in')) => [f, dest_dir]) do |out|
      render f, out.name, binding
    end
  end
  directory war_dir = "#{gem_dir}/lib/jenkins"
  warfile = file("#{war_dir}/jenkins.war" => war_dir) do |f|
    Dir.chdir(File.dirname(f.name)) do
      sh "wget http://updates.jenkins-ci.org/download/war/#{jenkins_version}/jenkins.war"
    end
  end
  
  gemspec = file("#{gem_dir}/jenkins-war.gemspec" => outs + [warfile]) do |f|
    Gem::Specification.new do |s|
      s.name        = "jenkins-war"
      s.version     = jenkins_version
      s.platform    = Gem::Platform::RUBY
      s.authors     = ["Charles Lowell"]
      s.email       = ["cowboyd@thefrontside.net"]
      s.homepage    = "http://rubygems.org/gems/jenkins-war"
      s.summary     = "fetch and use a specific jenkins version with rubygems"
      s.description = "download and install a specific version of the jenkins war file which can be used for either running a server, or for plugin development"
      s.rubyforge_project = "jenkins-war"

      # s.files         = `git ls-files`.split("\n")
      # s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
      s.executables   = ['jenkins.war']
      s.require_paths = ["lib"]
      sh "touch #{f.name}"
      sh "rm -rf #{gem_dir}/*.gem"
      Dir.chdir(gem_dir) do
        s.files = FileList['**/*'].to_a
        File.open("#{s.name}.gemspec", "w") do |f|
          f.write(s.to_ruby)
        end
      end
    end
  end
  
  gem = file "#{gem_dir}/jenkins-war-#{jenkins_version}.gem" => gemspec do
    Dir.chdir(gem_dir) do
      Gem::Builder.new(eval(File.read(File.basename(gemspec.name)))).build
    end
  end
  gem.invoke
end

task :install, :version do |t, options|
  Rake::Task["gem"].invoke(options.version)
  sh "gem install pkg/#{options.version}/jenkins-war-#{options.version}.gem"
end

task :push, :version do |t, options|
  Rake::Task["gem"].invoke(options.version)
  sh "gem push pkg/#{options.version}/jenkins-war-#{options.version}.gem"
end

task :clean do
  sh "rm -rf pkg"
end