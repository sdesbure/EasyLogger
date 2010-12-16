#require 'cover_me'
#require File.join(File.expand_path(File.dirname(__FILE__)), "..", "coverage", "cover_me_config")
require 'rspec'

Rspec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :r
  config.expect_with :rspec
  config.mock_with :rspec

  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, comment the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = false
end
