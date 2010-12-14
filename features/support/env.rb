require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'aruba'

module ArubaOverrides
  def detect_ruby_script(cmd)
    if cmd =~ /^easylog.rb /
      "rvm 1.9.2-head lib/#{cmd}"
    else
      super(cmd)
    end
  end
end