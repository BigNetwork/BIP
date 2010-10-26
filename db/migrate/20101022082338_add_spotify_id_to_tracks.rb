class AddSpotifyIdToTracks < ActiveRecord::Migration
  def self.up
    add_column :tracks, :spotify_id, :string
  end

  def self.down
    remove_column :tracks, :spotify_id
  end
end
