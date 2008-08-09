class CreateCreators < ActiveRecord::Migration
  def self.up
    drop_table :works_people
    create_table :creators do |t|
      t.timestamps
      t.column :work_id, :integer
      t.column :person_id, :integer
      t.column :relation, :string
    end
  end

  def self.down
    drop_table :creators
  end
end
