# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Oe60Naitei107SoccerFieldsManagementSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1
    config.active_record.default_timezone = :local

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))
    config.hosts << "e3f6-2405-4802-95f1-23de-6e58-e4f3-f5ce-7e8f.ngrok-free.app"
    config.hosts << "e3f6-2405-4802-95f1-23de-6e58-e4f3-f5ce-7e8f.ngrok-free.app"
    config.i18n.available_locales = %I[en vi]
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.default_locale = :en
    config.generators do |g|
      g.template_engine :erb, turbo_stream: true
    end
  end
end
