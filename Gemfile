source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'

gem 'pg', '~> 1.2', '>= 1.2.3'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'font-awesome-sass', '~> 5.15', '>= 5.15.1'
gem 'haml-rails', '~> 2.0', '>= 2.0.1'
gem 'simple_form', '~> 5.1'

gem 'faker', '~> 2.18'
gem 'devise', '~> 4.8'
gem 'friendly_id', '~> 5.4', '>= 5.4.2'
gem 'ransack', '~> 2.4', '>= 2.4.2'
gem 'public_activity', '~> 1.6', '>= 1.6.4'
gem 'rolify', '~> 6.0'
gem 'pundit', '~> 2.1'
gem 'exception_notification', '~> 4.4', '>= 4.4.3'
gem 'pagy', '~> 4.10', '>= 4.10.1'
gem 'chartkick', '~> 4.0', '>= 4.0.5'
gem 'groupdate', '~> 5.2', '>= 5.2.2'

gem 'workflow-activerecord', '~> 4.1', '>= 4.1.8'
gem 'ranked-model', '~> 0.4.7'

gem 'aws-sdk-s3', require: false
gem 'active_storage_validations', '~> 0.9.5'
gem 'image_processing', '~> 1.12', '>= 1.12.1' # requires imagemagick

gem 'recaptcha', '~> 5.8', '>= 5.8.1'

# authenticate with Google via OAuth2 in OmniAuth.
gem 'omniauth-google-oauth2', '~> 1.0'
gem 'omniauth-rails_csrf_protection', '~> 1.0'

# OmniAuth strategy for GitHub.
gem 'omniauth-github', '~> 2.0'

# Facebook OAuth2 Strategy for OmniAuth
gem 'omniauth-facebook', '~> 4.0'

# multi-step form
gem 'wicked'

group :development do
  gem 'letter_opener', '~> 1.7'
end

# nested forms
gem 'cocoon', '~> 1.2', '>= 1.2.15'

# PDF
gem 'wicked_pdf', '~> 2.1' # PDF for Ruby on Rails
gem 'wkhtmltopdf-binary', group: :development
gem 'wkhtmltopdf-heroku', group: :production