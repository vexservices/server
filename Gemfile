source 'https://rubygems.org'

ruby '2.2.0'

# Rails
gem 'rails', '4.1.15'
gem 'rails-observers'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'spring', group: :development

# Javascript
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-turbolinks'
gem 'turbolinks'
gem 'jquery-fileupload-rails'

# HTML Framework
gem 'bootstrap-sass'

# Tree structure
gem 'ancestry'

# SASS - Coffee
gem 'coffee-rails', '~> 4.0.0'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'

# Paypal Gateway
gem 'activemerchant'
# PagSeguro Gateway
gem "pagseguro-oficial", git: "git://github.com/pagseguro/ruby.git"

gem 'jbuilder', '~> 2.0'
gem 'pg'
gem 'pundit', github: 'elabs/pundit'
gem 'slim-rails'
gem 'therubyracer', :platform=>:ruby

# Authentication
gem 'devise'
gem 'simple_token_authentication', '~> 1.0'

# Email Validator
gem 'email_validator'

# help to kill N+1 queries and unused eager loading
gem 'bullet', :group => 'development'

# Data Translations
gem 'globalize', '~> 4.0.2'
gem 'globalize-accessors'
gem 'i18n_data'
gem 'http_accept_language'

# Forms
gem 'nested_form'
gem 'simple_form'
gem 'select2-rails'

# Images
gem 'carrierwave'
gem 'mini_magick'
gem 'carrierwave_backgrounder'
gem 'fastimage'

# Jobs
gem 'sinatra', require: false
gem 'sidekiq'

# Tabs
gem 'tabs_on_rails'

# Progress Bar
gem 'nprogress-rails'

# Pagination
gem 'kaminari'
gem 'bootstrap-kaminari-views'

# Country
gem 'countries', require: 'countries/global'
gem 'country_select', github: 'stefanpenner/country_select'

# Enumerations
gem 'enumerate_it'

# Heroku
gem 'asset_sync'
gem 'fog'

# NewRelic
gem 'newrelic_rpm'

# PDF
gem 'prawn'
gem 'prawn-table'

# Push Notification
gem 'gcm'
gem 'houston', github: 'nomad/Houston'

# Import XLS
gem 'roo'

# Create Zip
gem 'rubyzip'
gem 'httparty', '~> 0.13.1'

# Geocoder
gem 'geocoder'

# PaperTrail
gem 'paper_trail', '~> 3.0.6'

# Money
gem 'money'

# Google Maps
gem 'gmaps4rails'

# Search engine
gem 'ransack', github: 'activerecord-hackery/ransack', branch: 'rails-4.1'

# Encrypt password
gem 'bcrypt'

group :production, :staging do
  gem 'rails_12factor'
  gem 'dalli'

  #Webserver
  gem 'puma'
  gem 'rack-timeout'
end

group :development do
  gem 'quiet_assets'
  gem 'rails_layout'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'guard-rspec'
end

group :test do
  gem 'capybara', '< 2.6.0'
  gem 'selenium-webdriver', '>= 2.49.0'
  gem 'capybara-webkit', '>= 1.7.1'
  gem 'factory_girl_rails'
  gem 'rb-inotify', '~> 0.9'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'json-schema'
end
