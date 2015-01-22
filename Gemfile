source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'mysql2'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'bcrypt', '~> 3.1.7'
gem 'nokogiri', '~> 1.6.3'

gem 'redcarpet', '~> 3.2.1'
gem 'coderay'

gem 'acts-as-taggable-on', '~> 3.4'
gem 'ransack', github: 'activerecord-hackery/ransack'

gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-twitter'
gem 'figaro'

gem 'rails-i18n'

group :test do
  gem 'rspec-rails', '~> 3.1.0'
  gem 'capybara', '~> 2.4.1'
  gem 'launchy'
  gem 'factory_girl_rails', '~> 4.4.1'
end

group :development do
  gem "bullet"
  gem 'spring-commands-rspec', '~> 1.0.2'
  gem 'quiet_assets', '~> 1.0.3'
  gem 'annotate', '~> 2.6.5'
  gem 'pry', '~> 0.10.1'
  gem 'pry-rails', '~> 0.3.2'
  gem 'pry-byebug', '~> 2.0.0'
  gem 'capistrano', '~> 3.2.1', require: false
  gem 'capistrano-rails', '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano3-unicorn', '~> 0.2.1', require: false
end

group :production do
  gem 'unicorn', '~> 4.8.3'
end

# test warning
group :assets do
  gem 'coffee-rails'
end

gem 'google-analytics-rails'
