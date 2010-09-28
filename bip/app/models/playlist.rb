class Playlist < ActiveRecord::Base
  has_many :tracks
end
