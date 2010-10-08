class AddIsPlayingToPlaylists < ActiveRecord::Migration
  def self.up
    add_column :playlists, :is_playing, :integer
  end

  def self.down
    remove_column :playlists, :is_playing
  end
end
