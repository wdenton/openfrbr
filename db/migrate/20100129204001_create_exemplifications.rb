class CreateExemplifications < ActiveRecord::Migration
  def self.up
    remove_column :items, :manifestation_id
    create_table :exemplifications do |t|
      t.integer :item_id
      t.integer :manifestation_id
      t.string  :relation
      t.timestamps
    end
  end

  def self.down
    add_column :items, :manifestation_id
    drop_table :exemplifications
  end
end
