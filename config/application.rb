require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fukusuke
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :utc

    config.i18n.default_locale = :ja

    config.active_record.encryption.primary_key         = ENV["RAILS_ENC_PRIMARY_KEY"]
    config.active_record.encryption.deterministic_key   = ENV["RAILS_ENC_DETERMINISTIC_KEY"]
    config.active_record.encryption.key_derivation_salt = ENV["RAILS_ENC_KEY_DERIVATION_SALT"]

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
