source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '>= 5.0.0.beta4', '< 5.1'
gem 'pg', '~> 0.18'
gem 'redis', '~> 3.0'
gem 'puma', '~> 3.0'
gem 'jbuilder', '~> 2.0'
gem 'devise', '~> 4.0.1'
gem 'devise_token_auth', '~> 0.1.37'
gem 'pundit', '~> 1.1.0'


# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.5.0.beta3'
  gem 'factory_girl_rails', '~> 4.7.0'
  gem 'ffaker', '~> 2.2.0'
end

group :test do
  gem 'database_cleaner', '~> 1.5.3'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', '~> 0.11.2', :require => false
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
