require 'fileutils'
require 'pathname'
require 'securerandom'
require 'json'

Dir.glob("**/*.json").each do |episode_path|
  if File.basename(episode_path) == 'metadata.json'
    next
  end

  episode_data = JSON.parse(File.read(episode_path))

  if episode_data['segments'].length == 0
    p "deleting #{episode_path}"
    File.delete(episode_path)
    next
  end

  #check to see if we have any speakers

  has_speaker = false
  episode_data['segments'].each {|segment|

    if(segment['speaker'])
      has_speaker = true
      break
    end
  }
  if !has_speaker
    p "deleting #{episode_path}"
    File.delete(episode_path)
  else
    p "file has speakers #{episode_path}"
  end

  #p "#{episode_path} => #{pn.dirname}/#{episode_filename}.json"
  #File.rename(episode_path, "#{pn.dirname}/#{episode_filename}.json")

end
