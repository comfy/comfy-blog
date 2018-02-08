source "http://rubygems.org"

gemspec

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "kaminari"
  gem "puma"
  gem "rubocop", require: false
  gem "sqlite3"
end

group :development do
  gem "listen"
  gem "web-console"
end

group :test do
  gem "coveralls",  require: false
  gem "mocha",      require: false
  gem "rails-controller-testing"
end
