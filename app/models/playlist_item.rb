class PlaylistItem < ActiveRecord::Base
  belongs_to :track
  belongs_to :playlist
  has_many :votes, :dependent => :destroy
  
  validates_presence_of :playlist_id
  validates_presence_of :spotify_id
  validates_presence_of :track_id
  # Should maybe be unique in matter of track_id and playlist_id?
  #http://stackoverflow.com/questions/2533502/rails-3-validate-combined-values
  
  def total_votes_count
    votes_count.to_i + previous_votes_count.to_i
  end
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

