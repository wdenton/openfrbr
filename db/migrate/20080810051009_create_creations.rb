class CreateCreations < ActiveRecord::Migration
  def self.up
    create_table :creations do |t|
      t.column :person_id, :integer
      t.column :work_id, :integer
      t.column :relation, :string
    end
  end

  def self.down
    drop_table :creations
  end
end
