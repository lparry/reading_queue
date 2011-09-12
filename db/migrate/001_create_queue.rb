class CreateQueue < ActiveRecord::Migration
  def self.up
    create_table :queue_item do |t|
      t.string :url
      t.boolean :read

      t.timestamps
    end
  end
  
  def self.down
    drop_table :queue_item
  end
end
