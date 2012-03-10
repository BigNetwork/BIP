class PlaylistItem < ActiveRecord::Base
  belongs_to :track
  belongs_to :playlist, :counter_cache => true
  has_many :votes, :dependent => :destroy
  has_many :plays
  
  validates_presence_of :playlist_id
  validates_presence_of :spotify_id
  # The same track can only be added once per playlist:
  #http://stackoverflow.com/questions/2533502/rails-3-validate-combined-values
  validates :track_id, :presence => true, :uniqueness => {:scope => :playlist_id}

  def total_votes_count
    votes_count.to_i + previous_votes_count.to_i
  end

  def name
    track.full_name
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

