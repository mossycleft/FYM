class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.string    "itemid"
      t.string    "title"
      t.text      "description"
      t.string    "product_type"
      t.string    "google_product_category"
      t.string    "link"
      t.string    "price"
      t.string    "condition"
      t.string    "brand"
      t.string    "shipping_weight"
      t.string    "mpn"
      t.string    "image_link"
      t.string    "availability"
      t.string    "gtin"
      t.timestamps
    end
  end

  def self.down
    drop_table :feeds
  end
end
