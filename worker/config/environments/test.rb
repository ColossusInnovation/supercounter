Rails.application.configure do
  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://redis:6379/0' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://redis:6379/0' }
  end
end
