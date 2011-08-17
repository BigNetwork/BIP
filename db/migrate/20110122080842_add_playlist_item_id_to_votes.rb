class AddPlaylistItemIdToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :playlist_item_id, :integer
  end

  def self.down
    remove_column :votes, :playlist_item_id
  end
end
