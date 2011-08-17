class AddPreviousVotesCountToPlaylistItems < ActiveRecord::Migration
  def self.up
    add_column :playlist_items, :previous_votes_count, :integer, :default => 0
  end

  def self.down
    remove_column :playlist_items, :previous_votes_count
  end
end
