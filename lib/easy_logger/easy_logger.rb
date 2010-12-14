# @author Sylvain Desbureaux
module EasyLogger
  # = Class EasyLogger which will do all the job of matching the lines and showing it
  # @author Sylvain Desbureaux
  # 
  # == Attributes
  # @attr_reader [I/O]     log       the log file/stream that we'll look into
  # @attr_reader [Array]   objects   the objects to match in the log
  # @attr_reader [Array]   methods   the methods to match in the log
  # @attr_reader [Boolean] verbose   the verbosity of the output
  # @attr_reader [String]  separator the separator of the values in the log. it's "|" per default
  # 
  # == Use
  # There's two methods to use the class: file() and tail().
  # Both of them use the same parameters (the attributes of the class).
  # The log file need to be correctly formatted. the parser assumes that the log file has this format (with '|' as separator in the example):
  #     |some tag (example: the date and time)|some tag|...|object|method| free text
  # The Separator could be at the end of the free text but never in the middle so choose it carefully!
  # @see logging_example.rb for a working logger
  # 
  # === File
  # File will open the stream, parse and output the matching line and exit
  #
  # === Tail
  # Tail will open the end of the stream and parse and output the matching line and exit
  
  class EasyLogger
    
    # @param [I/O]     log       the log file/stream that we'll look into
    # @param [Array]   objects   the objects to match in the log
    # @param [Array]   methods   the methods to match in the log
    # @param [Boolean] verbose   the verbosity of the output
    # @param [String]  separator the separator of the values in the log. it's "|" per default
    # @return [I/O] the parsed I/O matching the objects and/or the methods 
    def file()
    
    end
    # @param (see EasyLogger#file)
    # @return [I/O] an "open" I/O matching the objects and/or the methods 
    def tail()
      
    end
  end
end
