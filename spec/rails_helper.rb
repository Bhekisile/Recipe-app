# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
# require 'support/factory_bot'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'shoulda/matchers'
require 'devise' # Add this line to include Devise

# ... (rest of the file remains unchanged)

RSpec.configure do |config|
  # ... (rest of the configuration remains unchanged)

  # Include Devise test helpers for request specs
  config.include Devise::Test::IntegrationHelpers, type: :request
end
