class Track < ActiveRecord::Base
  #belongs_to :playlist
  has_many :playlist_items, :dependent => :destroy
  has_many :playlists, :through => :playlist_items
  #has_many :votes, :dependent => :destroy
  has_many :votes, :through => :playlist_items
  #acts_as_list :scope => :playlist
  
  validates_presence_of :spotify_id
  
  def full_name
    artist + " - " + name
  end

  # Output length in minutes instead of seconds:
  def length_in_minutes
    "%.2f" % (read_attribute(:length) / 60) unless read_attribute(:length).blank?
  end

  # From a float to this: 3:59
  def length_as_string
    seconds = read_attribute(:length) || 0
    m = (seconds/60).floor
    s = (seconds - (m * 60)).round
    "%2d:%02d" % [ m, s ]
  end

  def fetch_cover_url
    require 'net/http'
    require 'json'
    #require 'CGI'
    bip_last_fm_api_key = "df16509ddceedad8dc111fa81a6154f6"
    url = URI.parse("http://ws.audioscrobbler.com/2.0/?method=track.getinfo&api_key=#{bip_last_fm_api_key}&format=json&artist=#{CGI::escape(artist)}&track=#{CGI::escape(name)}")
    resp = Net::HTTP.get_response(url)
    data = resp.body
    result = JSON.parse(data)
    
    if result.blank? || result["track"]["album"].nil?
      return nil
    else
      logger.info(result["track"]["album"]["image"])
      result["track"]["album"]["image"][1]["#text"]
    end
  end

  #def cover_url
  #  fetch_cover_url
  #end

end

# == Schema Information
#
# Table name: tracks
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  artist      :string(255)
#  album       :string(255)
#  href        :string(255)
#  popularity  :float
#  length      :float
#  playlist_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  position    :integer
#  votes_count :integer         default(0)
#  spotify_id  :string(255)
#

