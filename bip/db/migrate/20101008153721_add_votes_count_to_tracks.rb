class AddVotesCountToTracks < ActiveRecord::Migration
  def self.up
    add_column :tracks, :votes_count, :integer, :default => 0
    
    Track.reset_column_information
    Track.all.each do |t|
      Track.update_counters t.id, :votes_count => t.votes.length
    end
  end

  def self.down
    remove_column :tracks, :votes_count
  end
end
