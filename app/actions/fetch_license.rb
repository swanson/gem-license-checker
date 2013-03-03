require "nestful"
require "fuzzy_match"
require "uri"

class FetchLicense
  LICENSE_FILE_NAMES = ["LICENSE", "MIT-LICENSE", "License", "Licence", "COPYING", "License.txt"]
  attr_reader :gem_name

  def initialize(gem_name)
    @gem_name = gem_name
  end
  
  def fetch
    puts "Fetching license for: #{gem_name}"
    result = find_src_url
    src_url = result["source_code_uri"] || nil
    if src_url and src_url.include?("github")

      license_file = nil

      LICENSE_FILE_NAMES.each do |path|
        license_file = file_if_exists(src_url, path)
        break if license_file
      end

      if license_file
        match = find_closest_match(license_file)
        puts "..Detected #{match.name}"
        update_gem_license(match.id)
      else
        puts "..Could not find license file"
        update_gem_license(nil)
      end
    else
      puts "..Could not find source url"
      update_gem_license(nil)
    end
  end

  def find_src_url
    begin
      Nestful.json_get "http://rubygems.org/api/v1/gems/#{gem_name}.json"
    rescue
      nil
    end
  end

  def file_if_exists(base, path)
    url = "#{base}/raw/master/#{path}"
    puts url
    begin
      Nestful.get url
    rescue
      nil
    end
  end

  def find_closest_match(license_text)
    matcher = FuzzyMatch.new(License.all, :read => :contents)
    matcher.find(license_text)
  end

  def update_gem_license(license_id)
    project_gem = ProjectGem.where(name: gem_name).first
    if project_gem
      project_gem.license_id = license_id
      project_gem.save
    else
      ProjectGem.create(name: gem_name, license_id: license_id)
    end
  end

  def try_gemspec(latest_version)
    url = "http://production.s3.rubygems.org/quick/Marshal.4.8/#{gem_name}-#{latest_version}.gemspec.rz"
    uri = URI.parse(url)
    begin
      response = Net::HTTP.get_response(uri)
      gemspec = Marshal.load(Gem.inflate(response.body))
    rescue
      nil
    end
  end
end