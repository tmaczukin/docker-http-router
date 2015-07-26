require 'simplecov'
SimpleCov.start { add_filter '/spec' }

require 'bundler/setup'
Bundler.require

require_relative '../http_router'

require 'application_test_builder'

RSpec.configure do |config|
  config.profile_examples = 2
  config.order = :random
  config.tty = true
  Kernel.srand config.seed

  config.include ApplicationTestBuilder
end
