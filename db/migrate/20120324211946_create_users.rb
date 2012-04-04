class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string      "username", :limit  => 50, :null  => false
      t.string      "email", :limit  => 50, :null  => false
      t.string      "password", :limit  => 40 
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
