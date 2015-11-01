require 'fileutils'
require 'pathname'

Dir.glob("**/*.json").each do |episode_path|
  if File.basename(episode_path) == 'metadata.json'
    next
  end

  episode_filename = File.basename(episode_path,'.json')
  episode_filename.strip!
  episode_filename = episode_filename.gsub(/\s+/, '-')

  pn = Pathname.new(episode_path)


  #p "#{episode_path} => #{pn.dirname}/#{episode_filename}.json"
  File.rename(episode_path, "#{pn.dirname}/#{episode_filename}.json")

end
