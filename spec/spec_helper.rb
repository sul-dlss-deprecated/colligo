# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/poltergeist'
require 'support/capybara'
require 'fixtures/mods_records/mods_fixtures'
require 'fixtures/annotation_records/annotation_fixtures'
require 'fixtures/iiif_manifest_records/iiif_manifest_fixtures'
require 'webmock/rspec'

Capybara.register_driver :poltergeist do |app|
  # NOTE: bootstrap_slider.js is throwing js errors. So I set js_errors to false
  Capybara::Poltergeist::Driver.new(app, { timeout: 60, js_errors: false })
end
Capybara.javascript_driver = :poltergeist

Capybara.default_max_wait_time = 10

require 'coveralls'
Coveralls.wear!('rails')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

WebMock.enable!
WebMock.disable_net_connect!(:allow => [/127.0.0.1/, /localhost/] )

RSpec.configure do |config|
  config.include Capybara::DSL

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
