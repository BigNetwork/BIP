class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :name
      t.string :spotify_id
      t.integer :released

      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
