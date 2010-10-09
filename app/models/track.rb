class Track < ActiveRecord::Base
  belongs_to :playlist
  has_many :votes, :dependent => :destroy
  acts_as_list :scope => :playlist
  
  # Output length in minutes instead of seconds:
  def length_in_minutes
    "%.2f" % (read_attribute(:length) / 60) unless read_attribute(:length).blank?
  end

  def album_image_url
    require 'net/http'
    require 'json'
    bip_last_fm_api_key = "df16509ddceedad8dc111fa81a6154f6"
    url = URI.parse("http://ws.audioscrobbler.com/2.0/?method=track.getinfo&api_key=#{bip_last_fm_api_key}&format=json&artist=#{artist.gsub("\ ", "+")}&track=#{name.gsub("\ ", "+")}")
    resp = Net::HTTP.get_response(url)
    data = resp.body
    result = JSON.parse(data)

    unless result["track"]["album"].nil?
      result["track"]["album"]["image"][1]["#text"]
    end 
  end

end
