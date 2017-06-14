$: << "../../lib" << "./lib"
$LOAD_PATH.unshift File.dirname(__FILE__)
require 'rubygems'
require 'rake'

Dir.glob('lib/tasks/*.rake').each { |r| import r if r != 'resque' }

if ENV['RESQUE_WORKER'] == 'true'
  ROOT_PATH = File.expand_path("..", __FILE__)
  load File.join(ROOT_PATH, 'lib/tasks/resque.rake')
end
