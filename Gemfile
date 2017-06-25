source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.0'

# GLOBAL RUBY RAILS
gem 'rails', '~> 5.0.2'

# APPLICATION
gem 'figaro'

#CSS
gem 'bootstrap-will_paginate'
gem 'data-confirm-modal'
gem 'sass-rails', '~> 5.0'
gem 'select2-rails'
gem 'twitter-bootstrap-rails'

#JS
gem 'coffee-rails', '~> 4.2'
gem 'highcharts-rails'
gem 'jquery-datatables-rails', '~> 3.4.0'
gem 'jquery-ui-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-validation-rails'
gem 'lodash-rails'
gem 'therubyracer'
gem 'uglifier', '>= 1.3.0'

#ICONS
gem 'ionicons-rails'

# IMAGES
gem 'paperclip'

# AMAZON
gem 'vacuum'
gem 'rebay'

#AUTHENTICATION
gem 'cancancan'
gem 'devise'
gem 'rolify'

#SCRAPING

# IMPORT/EXPORTS : CSV | XLS | XLSX | PDF
gem 'nokogiri'

# GLOBALISATION & I18n
gem 'i18n-js', '3.0.0.rc2'
gem 'globalize', git: 'https://github.com/globalize/globalize'
gem 'activemodel-serializers-xml'

# GEOLOCALISATION || TIME || COUNTRIES
gem 'clockwork', require: false

#SERVER
gem 'puma', '~> 3.0'

#DATABASE
gem 'pg', '~> 0.18'

#TRAFFIC
gem 'ahoy_matey'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'capistrano-rails'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
