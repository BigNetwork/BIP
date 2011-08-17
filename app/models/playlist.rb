class Playlist < ActiveRecord::Base
  #has_many :tracks, :order => 'votes_count DESC'
  has_many :playlist_items, :order => 'votes_count DESC, created_at ASC'
  #has_many :tracks, :through => :playlist_items
end

# == Schema Information
#
# Table name: playlists
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  is_playing :integer
#

