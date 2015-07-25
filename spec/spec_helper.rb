require 'simplecov'
SimpleCov.start { add_filter '/spec' }

require 'bundler/setup'
Bundler.require

RSpec.configure do |config|
  config.profile_examples = 2
  config.order = :random
  config.tty = true
  Kernel.srand config.seed
end
