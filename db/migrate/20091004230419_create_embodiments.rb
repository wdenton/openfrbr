class CreateEmbodiments < ActiveRecord::Migration
  def self.up
    remove_column :manifestations, :expression_id
    create_table :embodiments do |t|
      t.integer :expression_id
      t.integer :manifestation_id
      t.string  :relation
      t.timestamps
    end
  end

  def self.down
    drop_table :embodiments
  end
end
