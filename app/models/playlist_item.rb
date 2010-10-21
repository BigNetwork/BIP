class PlaylistItem < ActiveRecord::Base
  belongs_to :track
  belongs_to :playlist
  #has_many :votes, :dependent => :destroy
end
