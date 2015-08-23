source 'https://rubygems.org'

ruby '2.1.3'

gem 'rails', '4.1.6'
gem 'pg'
gem 'haml'
gem 'jquery-rails'
gem "twitter-bootstrap-rails"
gem 'jbuilder', '~> 2.0'
gem 'annotate', '~> 2.6.5'
gem 'devise'
gem 'kaminari'

gem 'sdoc', '~> 0.4.0',          group: :doc

group :assets do
  gem 'sass-rails', '~> 4.0.3'
  gem 'coffee-rails', '~> 4.0.0'
  gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  gem 'uglifier', '>= 1.3.0'
  gem "therubyracer"
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'factory_girl_rails', require: false
  gem 'faker'
  gem 'fuubar'
  gem 'spring'
  gem 'capybara'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

group :production do
  gem 'heroku'
  gem 'rails_12factor'
end
