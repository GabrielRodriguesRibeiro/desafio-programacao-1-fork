ENV["RAILS_ENV"] ||= "test"
require 'simplecov'
SimpleCov.start 'rails' do
  
  add_filter '/bin/'
  add_filter '/db/'
  add_filter '/test/'
  
end
require_relative "../config/environment"
require "rails/test_help"
require 'database_cleaner'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors, with: :threads)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  def log_in(user)
    if integration_test?
      login_as(user, :scope => :user)
    else
      sign_in(user)
    end
  end

  # Add more helper methods to be used by all tests here...
end

DatabaseCleaner.strategy = :transaction

module AroundEachTest
  def before_setup
    super
    DatabaseCleaner.clean 
    DatabaseCleaner.start    
  end
end