class CreateClicks < ActiveRecord::Migration
  def self.up
    create_table :clicks do |t|
      t.integer   "link_id"
      t.string    "click_uuid"
      t.string    "ref_user_agent"
      t.string    "ref_url"
      t.string    "ref_ip"
      t.string    "ref_browser"
      t.string    "ref_os"
      t.string    "ref_platform"
      t.string    "ref_keyword"
      t.boolean   "sale", :default  => false
      t.boolean   "real_click", :default  => true
      t.boolean   "processed", :default  => false
      t.timestamps
    end
    add_index("clicks", "link_id")
    add_index("clicks", "processed")
    add_index("clicks", "real_click")
    add_index("clicks", "click_uuid")
    add_index("clicks", "sale")
  end

  def self.down
    drop_table :clicks
  end
end
