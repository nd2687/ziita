Rails.application.config do |c|
  c.i18n.load_path +=
    Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  c.i18n.available_locales = [ :ja ]
  c.i18n.enforce_available_locales = true
  c.i18n.default_locale = :ja
end
