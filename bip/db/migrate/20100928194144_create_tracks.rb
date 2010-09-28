class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :name
      t.string :artist
      t.string :album
      t.string :href
      t.float :popularity
      t.float :length
      t.integer :playlist_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
