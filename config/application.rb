require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'devise'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
ENV['RAILS_ADMIN_THEME'] = 'flatly_theme'
module Charitysquare
  class Application < Rails::Application
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    # Timezone::Configure.begin do |c|
    #   c.username = 'ritika@esferasoft.com'
    # end

    # config.time_zone = 'Kolkata'
    # config.active_record.default_timezone = 'Kolkata'
    
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)


    config.action_mailer.default_url_options = { :host=> "http://esferasoftsolutions.com" }
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                  587,
      domain:               'gmail.com',
      user_name:            'aman_katoch@esferasoft.com',
      password:             'esfera!1',
      authentication:       'plain',
      enable_starttls_auto: true  }
  end

end
