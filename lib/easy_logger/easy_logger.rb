require 'file/tail'
# @author Sylvain Desbureaux
module EasyLogger
  # = Class EasyLogger which will do all the job of matching the lines and showing it
  # @author Sylvain Desbureaux
  # 
  # == Attributes
  # @attr_reader [String]     log    the log file/stream that we'll look into
  # @attr_reader [Array]   classes   the classes to match in the log
  # @attr_reader [Array]   methods   the methods to match in the log
  # @attr_reader [Boolean] verbose   the verbosity of the output
  # @attr_reader [String]  separator the separator of the values in the log. it's "|" per default
  # 
  # == Use
  # There's two methods to use the class: file() and tail().
  # Both of them use the same parameters (the attributes of the class).
  # The log file need to be correctly formatted. the parser assumes that the log file has this format (with '|' as separator in the example):
  #     |some tag (example: the date and time)|some tag|...|class|method| free text
  # The Separator could be at the end of the free text but never in the middle so choose it carefully!
  # @see Logging a working logger example
  # 
  # === File
  # File will open the stream, parse and output the matching line and exit
  #
  # === Tail
  # Tail will open the end of the stream and parse and output the matching line and exit
  
  class EasyLogger
    
    # Display the relevant line of the log matching the classes/methods
    #
    # @param [String]  log       the log file/stream that we'll look into
    # @param [String]   classes   the classes to match in the log
    # @param [String]   methods   the methods to match in the log
    # @param [Boolean] verbose   the verbosity of the output
    # @param [String]  separator the separator of the values in the log. it's "|" per default
    def file(log, classes, methods, verbose, separator='|')
      result = String.new
      puts "Looking in #{log} I/O for line matching #{classes} classe(s) and #{methods} method(s) with separator '#{separator}'" if verbose && !classes.nil? && !methods.nil?
      puts "Looking in #{log} I/O for line #{methods} method(s) with separator '#{separator}'" if verbose && classes.nil? && !methods.nil?
      puts "Looking in #{log} I/O for line matching #{classes} classe(s) with separator '#{separator}'" if verbose && !classes.nil? && methods.nil?
      puts "Looking in #{log} I/O for all lines" if verbose && classes.nil? && methods.nil?
      classes =classes.split(',') unless classes.nil?
      methods =methods.split(',') unless methods.nil?
      classes.map!{|c| c.downcase} unless classes.nil?
      methods.map!{|m| m.downcase} unless methods.nil?
      line_number = 0
      line_match = 0
      IO.foreach(log) do |line| 
        line_number += 1
        if match(line,classes,methods, separator)
          puts line 
          line_match += 1
        end
        
      end
      puts "#{line_match} lines matched on the #{line_number} lines in the log" if verbose
    end
    
    # Display the relevant <u>new</u> lines of the log matching the classes/methods
    #
    # @param (see EasyLogger#file)
    def tail(log, classes, methods, verbose, separator='|')
      result = String.new
      puts "Tailing in #{log} I/O for line matching #{classes} classe(s) and #{methods} method(s) with separator '#{separator}'" if verbose && !classes.nil? && !methods.nil?
      puts "Tailing in #{log} I/O for line #{methods} method(s) with separator '#{separator}'" if verbose && classes.nil? && !methods.nil?
      puts "Tailing in #{log} I/O for line matching #{classes} classe(s) with separator '#{separator}'" if verbose && !classes.nil? && methods.nil?
      puts "Tailing in #{log} I/O for all lines" if verbose && classes.nil? && methods.nil?
      classes =classes.split(',') unless classes.nil?
      methods =methods.split(',') unless methods.nil?
      classes.map!{|c| c.downcase} unless classes.nil?
      methods.map!{|m| m.downcase} unless methods.nil?
      @line_number = 0
      @line_match = 0
      #      interrupted = false
      trap("INT") do
        puts "#{@line_match} lines matched on the #{@line_number} lines in the log" if verbose 
        break
      end
      begin
        File::Tail::Logfile.tail(log) do |line|
          @line_number += 1
          if match(line,classes,methods, separator)
            puts line 
            @line_match += 1
          end
          #        if interrupted
          #          break
          #        end
        end
      rescue
        nil
      end
    end
    
    # Verify if a line match the classes/method
    #
    # @private
    # @param [String] line the line to match the regexp
    # @param classes (see EasyLogger#file)
    # @param methods (see EasyLogger#file)
    # @param separator (see EasyLogger#file)
    # @return [Boolean] True if the line is matched, false if not 
    @private 
    def match(line,classes,methods,separator)
      unless line[0..-2].split(separator).length < 3
        methode = line[0..-2].split(separator)[-2].strip.downcase
        classe = line[0..-2].split(separator)[-3].strip.downcase
      
        (classes.nil? || classes.include?(classe)) && (methods.nil? || methods.include?(methode))
      else
        false
      end
    end
  end
end
