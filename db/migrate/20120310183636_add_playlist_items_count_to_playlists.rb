class AddPlaylistItemsCountToPlaylists < ActiveRecord::Migration
  def self.up
    add_column :playlists, :playlist_items_count, :integer, :default => 0
    
    Playlist.reset_column_information
    Playlist.all.each do |t|
      Playlist.update_counters t.id, :playlist_items_count => t.playlist_items.length
    end
  end

  def self.down
    remove_column :playlists, :playlist_items_count
  end
end
