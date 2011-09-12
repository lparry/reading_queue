class CreateQueue < ActiveRecord::Migration
  def self.up
    create_table :queue_items do |t|
      t.string :url
      t.boolean :read, :default => false, :null => false

      t.timestamps
    end
  end
  
  def self.down
    drop_table :queue_items
  end
end
