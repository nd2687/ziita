# Be sure to restart your server when you modify this file.
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
%w(admin user preview).each do |name|
  Rails.application.config.assets.precompile += [ "#{name}.css", "#{name}.js" ]
end

Rails.root.join('vendor', 'assets', 'bower_components').to_s.tap do |bower_path|
  Rails.application.config.sass.load_paths << bower_path
  Rails.application.config.assets.paths << bower_path
end

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets',
  'bower_components', 'bootstrap-sass-official', 'assets', 'fonts')

Rails.application.config.assets.precompile << 
  %r(bootstrap/[\w-]+\.(?:eot|svg|ttf|woff)$)
