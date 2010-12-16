require 'logger'
# @author Sylvain Desbureaux
# Most of work grabbed from nuby on rails Hodel 3000 logger 
# http://nubyonrails.com/articles/a-hodel-3000-compliant-logger-for-the-rest-of-us.
# 
# I've added the way to retrieve the method which sent the log and the class via caller method.
# 
# I've also taken care to take the next one in caller if the methode is lik each, block,...
# 
# In your environmment file(s) (development.rb, test.rb,...) you'll need to add that in order to use this logger:
# @example
#   require File.dirname(__FILE__) + "/../../app/models/logging"
#   config.logger = Logging.new(config.paths.log.first )
# 
# And you'll need to put this file (renammed logging.rb here) in app/models folder
class Logging < Logger
  def format_message(severity, timestamp, progname, msg)
    i = 2
    methode = caller[i].split('`')[1].split("'")[0]
    each_true = false
    puts methode if methode == "each"
    each_true = true if methode == ""
    while methode == "debug" || methode == "info" || methode == "error" || methode.split(' ')[0] == "each"
      i += 1
      methode = caller[i].split('`')[1].split("'")[0]
      puts methode if each_true
    end
    methode = methode.split(' ')[0] == "block" ? methode.split(' ')[-1].center(17) : methode.center(17)
    objecte = caller[i].split(':')[0].split('/')[-1].split('.')[0].camelize.center(16)
    "#{timestamp.strftime("%d %b %H:%M:%S")}|rails[#{$PID}]|#{severity.center(8)}|#{objecte}|#{methode}| #{msg2str(msg).gsub(/\n/, '').lstrip}\n"
  end
  

  def msg2str(msg)
    case msg
    when ::String
      msg
    when ::Exception
      "#{ msg.message } (#{ msg.class }): " <<
      (msg.backtrace || []).join(" | ")
    else
      msg.inspect
    end
  end
  
end
