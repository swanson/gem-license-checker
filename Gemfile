source 'https://rubygems.org'

gem "sinatra"
gem "sinatra-activerecord"
gem "sinatra-flash"

gem "rake"
gem "nestful"
gem "delayed_job_active_record"

gem "gems"
gem "gemnasium-parser"
gem "fuzzy_match"

gem "haml"

group :production do
  gem "unicorn"
  gem "pg"
end

group :development do
  gem "sqlite3"
end

group(:development, :testing) do
  gem "pry"
  gem "rspec"
  gem "rack-test"
  gem "shotgun"
  gem "racksh"
end