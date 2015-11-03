require 'fileutils'
require 'pathname'
require 'securerandom'
require 'json'

Dir.glob("**/*.json").each do |episode_path|
  if File.basename(episode_path) == 'metadata.json'
    next
  end

  episode_data = JSON.parse(File.read(episode_path))

  episode_data['segments'] = episode_data['segments'].reduce([]) {|memo, (key, val)|

    val['uuid'] = SecureRandom.uuid

    memo.push(val)
  }.sort! { |a,b| a['timestamp'] <=> b['timestamp'] }
  p episode_data['segments']

  File.write(episode_path, JSON.pretty_generate(episode_data))
  #p "#{episode_path} => #{pn.dirname}/#{episode_filename}.json"
  #File.rename(episode_path, "#{pn.dirname}/#{episode_filename}.json")

end
