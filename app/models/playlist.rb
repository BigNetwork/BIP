class Playlist < ActiveRecord::Base
  has_many :tracks, :order => 'votes_count DESC'
end
