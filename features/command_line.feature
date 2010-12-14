Feature: Command Line
    In order to launch the EasyLogger
    As a rails developper
    I want to use the command line to use EasyLogger
    
    Scenario: Help options
    Given nothing
    When I run  "EasyLog help" 
    Then I should have the help of the script
    
    Scenario: Help options
    Given nothing
    When I run  "EasyLog --version help" 
    Then I should have the help of the script
    
    