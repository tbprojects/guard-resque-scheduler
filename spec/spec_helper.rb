require 'rspec'
require 'guard/resque-scheduler'

ENV['GUARD_ENV'] = 'test'

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end
