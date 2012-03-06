class AddPlaysCountToPlaylistItems < ActiveRecord::Migration
  def self.up
    add_column :playlist_items, :plays_count, :integer, :default => 0
    
    PlaylistItem.reset_column_information
    PlaylistItem.all.each do |t|
      PlaylistItem.update_counters t.id, :plays_count => t.plays.length
    end
  end

  def self.down
    remove_column :playlist_items, :plays_count
  end
end
