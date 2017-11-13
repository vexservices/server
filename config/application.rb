require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'active_merchant/billing/rails'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VirtualExchange
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[File.join(Rails.root, 'config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :en
    config.i18n.available_locales = ['pt-BR', :en, :es, :api]

    # Lib folder
    config.autoload_paths += %W(#{config.root}/lib )

    # Observer
    config.active_record.observers = :store_observer, :schedule_observer,
      :message_observer, :push_observer, :change_observer,
      :product_observer, :price_observer, :seller_observer,
      :app_observer, :picture_observer, :store_seller_observer,
      :store_counter_observer, :notification_observer

    # Custom error pages
    config.exceptions_app = self.routes
  end
end
