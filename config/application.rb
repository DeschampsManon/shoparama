require_relative 'boot'

require 'rails/all'
Bundler.require(*Rails.groups)

module Shoparama
  class Application < Rails::Application
    config.serve_static_assets = true
    config.assets.initialize_on_precompile = false
    config.middleware.use I18n::JS::Middleware
  end
end
