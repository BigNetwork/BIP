class PlaylistItem < ActiveRecord::Base
  belongs_to :track
  belongs_to :playlist
  #has_many :votes, :dependent => :destroy
end

# == Schema Information
#
# Table name: playlist_items
#
#  id          :integer         not null, primary key
#  playlist_id :integer
#  track_id    :integer
#  votes_count :integer
#  created_at  :datetime
#  updated_at  :datetime
#  spotify_id  :string(255)
#

