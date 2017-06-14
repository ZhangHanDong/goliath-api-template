# require 'rubygems'
#
# ENV["RACK_ENV"] ||= 'test'
#
# require 'em-synchrony/em-http'
# require 'goliath/test_helper'
# require 'rack/test'
#
# require File.expand_path("../../config/server", __FILE__)
# require 'database_cleaner'
#
# require 'factory_girl'
# Dir.glob(File.dirname(__FILE__) + "/factories/*").each do |factory|
#   require factory
# end
#
#
# Goliath.env = :test
#
# RSpec.configure do |config|
#   config.mock_with :rspec
#   config.expect_with :rspec
#   config.include Goliath::TestHelper, :example_group => { :file_path => /spec\/integration/}
#   config.include FactoryGirl::Syntax::Methods
#
#   config.before(:all) do
#     DatabaseCleaner.strategy = :transaction
#     DatabaseCleaner.clean_with(:truncation)
#   end
#
#   config.before do
#     DatabaseCleaner.start
#   end
#
#   config.after do
#     # make sure we reset back to default locale in case a test left us set otherwise
#     I18n.locale = 'zh-CN'
#     DatabaseCleaner.clean
#   end
# end
#
#
#
#
# def simple_app
#   lambda do |env|
#     [ 200, {'Content-Type' => 'text/plain'}, ["HELLO"] ]
#   end
# end
