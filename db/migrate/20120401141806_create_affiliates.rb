class CreateAffiliates < ActiveRecord::Migration
  def self.up
    create_table :affiliates do |t|
      t.string "affiliate_name"
      t.text "remarketing_code", :limit  => 1000
      t.timestamps
    end
        add_index("affiliates", "remarketing_code", :length => 100)
        add_index("affiliates", "affiliate_name")
  end

  def self.down
    drop_table :affiliates
  end
end
