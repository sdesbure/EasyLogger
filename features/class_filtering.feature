Feature: Class Filtering

  In order to read more efficiently my log files
  As an EasyLogger Viewer, 
  I want to be able to filter some lines according to the class
  
  @filtering @announce
  Scenario: Basic Filtering
  Given I write to "testlog.log" with:
  """
  13 Dec 11:35:51|rails[24735]|  INFO  |   Network   |  create_links   | 1
  13 Dec 11:35:52|rails[24735]|  INFO  |    Super    |  create_links   | 2
  13 Dec 11:35:53|rails[24735]|  INFO  |   Network   |  create_links   | 3
  13 Dec 11:35:54|rails[24735]|  INFO  |    Super    |  create_links   | 4
  13 Dec 11:35:55|rails[24735]|  INFO  |   Network   |  create_links   | 5
  13 Dec 11:35:56|rails[24735]|  INFO  |    Super    |  create_links   | 6
  13 Dec 11:35:57|rails[24735]|  INFO  |   Network   |  create_links   | 7
  13 Dec 11:35:58|rails[24735]|  INFO  |    Super    |  create_links   | 8
  13 Dec 11:35:59|rails[24735]|  INFO  |   Network   |  create_links   | 9
  """
  When I run "rvm 1.8.7-head exec ../../bin/EasyLogger text -f -c Network testlog.log"
  Then the output should contain:
  """
  13 Dec 11:35:51|rails[24735]|  INFO  |   Network   |  create_links   | 1
  13 Dec 11:35:53|rails[24735]|  INFO  |   Network   |  create_links   | 3
  13 Dec 11:35:55|rails[24735]|  INFO  |   Network   |  create_links   | 5
  13 Dec 11:35:57|rails[24735]|  INFO  |   Network   |  create_links   | 7
  13 Dec 11:35:59|rails[24735]|  INFO  |   Network   |  create_links   | 9
  """ 
  And the output should not contain "Super"
  
  @filtering @announce
  Scenario: "Complex" Filtering
  Given I write to "testlog.log" with:
  """
  13 Dec 11:35:51|rails[24735]|  INFO  |   Network   |  create_links   | 1
  13 Dec 11:35:52|rails[24735]|  INFO  |    Super    |  create_links   | 2
  13 Dec 11:35:53|rails[24735]|  INFO  |   Network   |  create_links   | 3
  13 Dec 11:35:54|rails[24735]|  INFO  |    Super    |  create_links   | 4
  13 Dec 11:35:55|rails[24735]|  INFO  |   Network   |  create_links   | 5
  13 Dec 11:35:56|rails[24735]|  INFO  |    Super    |  create_links   | 6
  13 Dec 11:35:57|rails[24735]|  INFO  |   Network   |  create_links   | 7
  13 Dec 11:35:58|rails[24735]|  INFO  |    Super    |  create_links   | 8
  13 Dec 11:35:59|rails[24735]|  INFO  |   Network   |  create_links   | 9
  13 Dec 11:35:51|rails[24735]|  INFO  |   Networks  |  create_links   | 1
  13 Dec 11:35:52|rails[24735]|  INFO  |    Super    |  create_links   | 2
  13 Dec 11:35:53|rails[24735]|  INFO  |   Networks  |  create_links   | 3
  13 Dec 11:35:54|rails[24735]|  INFO  |    Super    |  create_links   | 4
  13 Dec 11:35:55|rails[24735]|  INFO  |   Networks  |  create_links   | 5
  13 Dec 11:35:56|rails[24735]|  INFO  |    Super    |  create_links   | 6
  13 Dec 11:35:57|rails[24735]|  INFO  |   Networks  |  create_links   | 7
  13 Dec 11:35:58|rails[24735]|  INFO  |    Super    |  create_links   | 8
  13 Dec 11:35:59|rails[24735]|  INFO  |   Networks  |  create_links   | 9
  13 Dec 11:35:51|Network[24735]|  INFO  |   Networks  |  create_links   | 1
  13 Network 11:35:52|rails[24735]|  INFO  |    Super    |  create_links   | 2
  13 Dec 11:35:53|rails[24735]|  INFO  |   Networks  |  Network   | 3
  13 Dec 11:35:54|rails[24735]|  INFO  |    Super    |  create_links   | Network
  13 Dec 11:35:54|rails[24735]|  Network  |    Super    |  create_links   | 10
  """
  When I run "rvm 1.8.7-head exec ../../bin/EasyLogger text -f -c Network testlog.log"
  Then the output should contain:
  """
  13 Dec 11:35:51|rails[24735]|  INFO  |   Network   |  create_links   | 1
  13 Dec 11:35:53|rails[24735]|  INFO  |   Network   |  create_links   | 3
  13 Dec 11:35:55|rails[24735]|  INFO  |   Network   |  create_links   | 5
  13 Dec 11:35:57|rails[24735]|  INFO  |   Network   |  create_links   | 7
  13 Dec 11:35:59|rails[24735]|  INFO  |   Network   |  create_links   | 9
  """ 
  And the output should not contain "Super"
  And the output should not contain "Networks"
  And the output should not contain: 
  """
  13 Dec 11:35:51|Network[24735]|  INFO  |   Networks  |  create_links   | 1
  13 Network 11:35:52|rails[24735]|  INFO  |    Super    |  create_links   | 2
  13 Dec 11:35:53|rails[24735]|  INFO  |   Networks  |  Network   | 3
  13 Dec 11:35:54|rails[24735]|  INFO  |    Super    |  create_links   | Network
  13 Dec 11:35:54|rails[24735]|  Network  |    Super    |  create_links   | 10
  """
  
