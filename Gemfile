source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem('rails', '4.2.5.1')
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use Bootstrap 4
gem 'bootstrap', '~> 4.0.0.alpha3'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates  the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'faker', '~> 1.6.1'
gem 'cowsay'
gem 'gemoji'
gem 'quiet_assets'
gem 'kaminari'
gem "font-awesome-rails"
# mailer gems
gem "delayed_job_active_record"
gem "delayed_job_web"
gem "active_model_serializers"
gem "devise"
gem 'activeadmin', github: 'activeadmin'

gem 'slim-rails'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'cancancan'
# this gem is used for when we make a front-end-facing client that wants to make ajax requests
gem 'rack-cors', :require => 'rack/cors'
# omniauth twitter gem strategy
gem 'omniauth-twitter'
gem "twitter"

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-rails'
  # gem "pry-byebug"
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'rails-erd'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem "letter_opener"
end


group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 3.4.2'
  gem 'factory_girl_rails'
  gem 'guard-rspec', require: false
  gem 'hirb'
  gem 'awesome_print'
  gem 'interactive_editor'

end

group :production do
  gem 'puma'
  gem 'rails_12factor'
end
