source 'http://rubygems.org'

gem 'rails', '3.1.10'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem 'sass-rails', '~> 3.1.4'
	gem 'coffee-rails', '~> 3.1.1'
	gem 'uglifier', '>= 1.0.3'
	gem 'compass-rails', '~> 1.0.3'
	gem 'bootstrap-sass', '1.4.0'
end

gem 'jquery-rails'

gem 'haml', '~> 3.1.3'

gem 'sorcery', '~> 0.7.2'

gem 'lazy_high_charts', :git => 'git://github.com/michelson/lazy_high_charts.git'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
	gem 'heroku_san'
	gem 'quiet_assets'
end

group :development, :test do
	gem 'sqlite3'
end

group :test do
	# Pretty printed test output
	gem 'turn', :require => false
end

group :production do
	gem 'pg', '~> 0.11.0'
	gem 'thin', '~> 1.2.11'
end


