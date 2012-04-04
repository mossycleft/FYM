class CreateClicks < ActiveRecord::Migration
  def self.up
    create_table :clicks do |t|
      t.integer   "link_id"
      t.string    "ref_url"
      t.string    "ref_ip"
      t.string    "ref_domain"
      t.string    "ref_language"
      t.string    "ref_browser"
      t.string    "ref_os"
      t.string    "ref_platform"
      t.string    "ref_keyword"
      t.boolean   "sale", :default  => false
      t.timestamps
    end
    add_index("clicks", "link_id")
  end

  def self.down
    drop_table :clicks
  end
end
