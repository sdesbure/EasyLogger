#require 'cover_me'
#require File.join(File.expand_path(File.dirname(__FILE__)), "..", "..", "coverage", "cover_me_config")
require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'aruba/cucumber'

#module ArubaOverrides
#  def detect_ruby_script(cmd)
#    if cmd =~ /^EasyLogger /
#      "rvm 1.9.2-head exec bin/#{cmd}"
#    else
#      super(cmd)
#    end
#  end
#end