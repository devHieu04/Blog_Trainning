require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module BlogTrain
  class Application < Rails::Application
    config.load_defaults 7.0
    config.action_controller.default_protect_from_forgery = false
    require_relative "initializers/cors"
  end
end
