require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ModernChessRails
  class Application < Rails::Application

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # CORS configuration
    config.action_dispatch.default_headers = {
        'Access-Control-Allow-Credentials' => 'true',
        'Access-Control-Allow-Origin'  => 'http://localhost:4200',
        'Access-Control-Allow-Headers' => 'Origin, Content-Type, Accept, Authorization, Token',
        'Access-Control-Allow-Methods' => 'GET, POST, PUT, DELTE, OPTIONS'

        #'Access-Control-Request-Method' => %w{GET POST PUT DELETE OPTIONS}.join(",")
    }

    config.middleware.insert_before 0, "Rack::Cors", :debug => true, :logger => (-> { Rails.logger }) do
      allow do
        origins '*'

        #resource '/cors',
        #  :headers => :any,
        #  :methods => [:post],
        #  :credentials => true,
        #  :max_age => 0

        resource '*',
          :headers => :any,
          :methods => [:get, :post, :delete, :put, :patch, :options, :head],
          :max_age => 178200
      end
    end
  end
end
