source 'https://rubygems.org'

ruby '2.4.2'

# Rails
gem 'rails'
gem 'rails-observers'
gem 'sdoc'
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
gem 'coffee-rails'
gem 'sass-rails'
gem 'uglifier'

# Paypal Gateway
gem 'activemerchant'
# PagSeguro Gateway
gem "pagseguro-oficial", git: "git://github.com/pagseguro/ruby.git"

gem 'jbuilder'
gem 'pg'
gem 'pundit', github: 'elabs/pundit'
gem 'slim-rails'
gem 'therubyracer', :platform=>:ruby

# Authentication
gem 'devise'
gem 'simple_token_authentication'

# Email Validator
gem 'email_validator'

# help to kill N+1 queries and unused eager loading
gem 'bullet', :group => 'development'

# Data Translations
gem 'globalize'
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
#gem 'sinatra', require: false
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
gem 'fog-aws'

# NewRelic

# PDF
gem 'prawn'
gem 'prawn-table'

# Push Notification
gem 'gcm'
gem 'houston', github: 'nomad/Houston'

# Import XLS
# https://github.com/roo-rb/roo/issues/378
gem 'roo', '2.6.0'

# Create Zip
gem 'rubyzip'
gem 'httparty'

# Geocoder
gem 'geocoder'

# PaperTrail
gem 'paper_trail'

# Money
gem 'money'

# Google Maps
gem 'gmaps4rails'

# Search engine
gem 'ransack'

# Encrypt password
gem 'bcrypt'

group :production, :staging do
  gem 'rails_12factor'
  gem 'dalli'

  #Webserver
  #gem 'puma'
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
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'factory_girl_rails'
  gem 'rb-inotify'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'json-schema'
end

#Environment variables
gem 'figaro'

#Capistrano
gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-bundler'
gem 'capistrano-rails-db'
gem 'capistrano-sidekiq'
