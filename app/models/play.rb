class Play < ActiveRecord::Base
	belongs_to :playlist_item
	
	after_save :touch_playlist
	
	def touch_playlist
	  playlist_item.playlist.touch if playlist_item && playlist_item.playlist
  end
end
