class CreatePlays < ActiveRecord::Migration
  def self.up
    create_table :plays do |t|
      t.integer :playlist_item_id

      t.timestamps
    end
  end

  def self.down
    drop_table :plays
  end
end
