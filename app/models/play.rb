class Play < ActiveRecord::Base
	belongs_to :playlist_item
	#belongs_to :playlist, :through => :playlist_item
end
