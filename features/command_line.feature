Feature: Command Line
  In order to launch the EasyLogger
  As a rails developper
  I want to use the command line to use EasyLogger
    
  Scenario: gli is in the gems
  When I run "rvm 1.8.7-head exec gem list"
  Then the output should contain "gli"
  Then the output should contain "file-tail"
    
  Scenario: Help options
  When I run "rvm 1.8.7-head exec ../../bin/EasyLogger help" 
  Then the output should contain:
  """
  usage: EasyLogger command

  Version: 0.1

  Commands:
      help - Shows list of commands or help for one command
      text - View the line matching model and/or methods on a log file in command 
             line
  """
    
    