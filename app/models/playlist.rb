class Playlist < ActiveRecord::Base
  has_many :tracks, :order => 'votes_count DESC'
  has_many :playlist_items
  #has_many :tracks, :through => :playlist_items
end
