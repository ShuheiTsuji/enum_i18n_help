require "active_record"
require "pry"
require "bundler/setup"
require "rspec"
Bundler.require

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

I18n.load_path += Dir["#{File.dirname(__FILE__)}/fixtures/locales/*.yml"]
I18n.enforce_available_locales = false

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
