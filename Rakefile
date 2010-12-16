require 'rake/clean'
require 'rubygems'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'bundler'
require 'cucumber/rake/task'


Bundler::GemHelper.install_tasks

Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  rd.title = 'Your application title'
end

spec = eval(File.read('EasyLogger.gemspec'))

Rake::GemPackageTask.new(spec) do |pkg|
end

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/tc_*.rb']
end

task :default => :test

require 'rspec/core/rake_task'

desc "Run all tests"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["-c", "-f progress"]
  t.pattern = 'spec/**/*_spec.rb'
end

namespace :cover_me do
  
  task :report do
    require 'cover_me'
    require File.join(File.expand_path(File.dirname(__FILE__)), "coverage", "cover_me_config")
    CoverMe.complete!
  end
  
end

namespace :cov do
  Cucumber::Rake::Task.new(:cucumber) do |t|    
    t.rcov = true
    t.rcov_opts = %w{ -Ilib --exclude .rvm\/,osx\/objc,gems\/,spec\/,features\/,doc\/ --aggregate coverage.data}
    t.rcov_opts << %w{ -T} 
        t.rcov_opts << %[-o "coverage.features"]
  end
 
  RSpec::Core::RakeTask.new(:rspec) do |t|
    t.pattern = 'spec/**/*_spec.rb'
    t.rcov = true
    t.rcov_opts = %w{ -Ilib --exclude .rvm\/,osx\/objc,gems\/,spec\/,features\/ --aggregate coverage.data}
    t.rcov_opts << %w{ -T}
    t.rcov_opts << %[-o "coverage.spec"]
  end
 
  desc "Run both specs and features to generate aggregated coverage"
  task :all do |t|
    rm "coverage.data" if File.exist?("coverage.data")
    Rake::Task['cov:cucumber'].invoke
    Rake::Task["cov:rspec"].invoke
  end
end

