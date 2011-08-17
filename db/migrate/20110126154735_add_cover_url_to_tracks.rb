class AddCoverUrlToTracks < ActiveRecord::Migration
  def self.up
    add_column :tracks, :cover_url, :string
  end

  def self.down
    remove_column :tracks, :cover_url
  end
end
