require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ziita
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.i18n.load_path +=
      Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [ :ja ]
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :ja
    config.active_record.default_timezone = :local
    # config.active_record.raise_in_transactional_callbacks = true

    ActsAsTaggableOn.force_lowercase = true
    ActsAsTaggableOn.remove_unused_tags = true
  end
end
