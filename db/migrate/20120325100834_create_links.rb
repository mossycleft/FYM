class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.integer   "affiliate_id"
      t.string    "name"
      t.string    "url"
      
      t.timestamps
    end
      add_index("links", "id")
      add_index("links", "url")
      add_index("links", "name")
      add_index("links", "affiliate_id")
  end

  def self.down
    drop_table :links
  end
end
