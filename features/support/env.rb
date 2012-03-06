require 'active_record'
require 'database_cleaner'

# require all of our model classes
Dir[File.dirname(__FILE__) + '/../../models/*.rb'].each {|file| require file }

ActiveRecord::Base.establish_connection(YAML.load(File.read(File.join('config','database.yml')))[ENV['ENV'] ? ENV['ENV'] : 'development'])

begin
  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end