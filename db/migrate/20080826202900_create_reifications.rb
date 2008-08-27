class CreateReifications < ActiveRecord::Migration
  def self.up
    remove_column :expressions, :work_id
    create_table :reifications do |t|
      t.integer :work_id
      t.integer :expression_id
      t.string  :relation
    end
  end

  def self.down
    drop_table :reifications
  end
end
