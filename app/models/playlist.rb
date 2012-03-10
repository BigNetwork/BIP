class Playlist < ActiveRecord::Base
  #has_many :tracks, :order => 'votes_count DESC'
  has_many :playlist_items, :order => 'votes_count DESC, created_at ASC'
  #has_many :tracks, :through => :playlist_items
  has_many :plays, :through => :playlist_items, :order => :created_at
  has_many :votes, :through => :playlist_items
  
  def latest_status_at
    logger.info "playlist #{id} has #{plays.count} plays"
    if is_playing? && plays.first
      plays.first.created_at
    else
      updated_at
    end
  end
  
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

