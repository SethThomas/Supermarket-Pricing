require 'active_record'
require 'factory_girl'
Dir[File.dirname(__FILE__) + '/../models/*.rb'].each {|file| require file }
require 'factories'
require 'database_cleaner'
ActiveRecord::Base.establish_connection(YAML.load(File.read(File.join('config','database.yml')))[ENV['ENV'] ? ENV['ENV'] : 'development'])

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end