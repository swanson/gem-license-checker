require "sinatra/activerecord/rake"
require "rubygems"
require "bundler"
Bundler.require

require "./app"

namespace :jobs do 
  task :fetch do
    FetchLicense.new("shotgun").fetch
  end

  desc "Clear the delayed_job queue."
  task :clear do
    Delayed::Job.delete_all
  end
 
  desc 'delayed_job worker process'
  task :work do
    Delayed::Worker.new(:min_priority => ENV['MIN_PRIORITY'], :max_priority => ENV['MAX_PRIORITY']).start
  end
end

namespace :license do
  task :seed do
    puts "Seeding"
    Dir.glob("db/seeds/*") do |file|
      license_name = file.split("/").last
      puts "..#{license_name}"

      license = License.where(name: license_name).first
      if license
        license.contents = File.read(file)
        license.save
      else
        License.create(name: license_name, contents: File.read(file))
      end
    end
  end
end