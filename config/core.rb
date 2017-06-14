require 'fileutils'
require 'cgi'
require 'active_support'
require 'active_support/dependencies'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/time_with_zone'
require 'uri'
require 'goliath'
require 'goliath/plugins/latency'
require 'em-synchrony/activerecord'
require 'yaml'
require 'mysql2'
require 'paperclip'
require 'protected_attributes'
require 'grape'
require 'grape_entity'
require 'dalli'
require 'active_merchant'
require 'jbuilder'
require 'resque'
# require 'active_job'


module Goliath
  class << self

    def root
      ::File.expand_path('../../', __FILE__)
    end

    def root_path *dirs
      ::File.join(root, *dirs)
    end

    def initialize!
      load_path
      load_init_files
      load_application
    end

    private
    def load_path
      %w[app/apis app/models app/helpers app/middlewares app/entities app/engine app/jobs app/models_ext lib].each {|folder| $: << File.expand_path("./#{folder}", root) }
    end

    def load_init_files
      Dir[File.expand_path("./config/initializers/*.rb", root)].each {|file| require file }
    end

    def load_application
      require File.expand_path("./config/all", root)
    end
  end
end

# Initialize environment
Goliath.initialize!
