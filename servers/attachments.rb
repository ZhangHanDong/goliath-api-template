$: << "../../app" << "./app"
$: << "../../config" << "./config"

ENV['RACK_ENV'] ||= "test"

require File.expand_path('../../config/application', __FILE__)

require 'engine/apis/attachments'
require 'engine/attachments_server'
