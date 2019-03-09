require_relative 'boot'

# We don't really use Rails here, but we use `bundle exec sidekiq` which
# will end up using some Rails config to load classes and things
require "rails"
require "active_model/railtie"

Bundler.require(*Rails.groups)

module Worker
  class Application < Rails::Application
    config.load_defaults 5.2
    config.api_only = true
  end
end
