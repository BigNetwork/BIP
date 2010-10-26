class AddSpotifyIdToPlaylistItems < ActiveRecord::Migration
  def self.up
    add_column :playlist_items, :spotify_id, :string
  end

  def self.down
    remove_column :playlist_items, :spotify_id
  end
end
