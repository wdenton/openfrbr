class CreateCorporateBodies < ActiveRecord::Migration
  def self.up
    create_table :corporate_bodies do |t|
      t.timestamps
      t.column :name, :string
      t.column :dates, :string
      t.column :other_designation, :string
      t.column :place, :string
      t.column :comment, :string
    end

    create_table :works_corporate_bodies, :id => false do |t|
      t.timestamps
      t.column :work_id, :integer
      t.column :corporate_body_id, :integer
    end

    create_table :expressions_corporate_bodies, :id => false do |t|
      t.timestamps
      t.column :expression_id, :integer
      t.column :corporate_body_id, :integer
    end

    create_table :manifestations_corporate_bodies, :id => false do |t|
      t.timestamps
      t.column :manifestation_id, :integer
      t.column :corporate_body_id, :integer
    end
   
    create_table :items_corporate_bodies, :id => false do |t|
      t.timestamps
      t.column :item_id, :integer
      t.column :corporate_body_id, :integer
    end

  end

  def self.down
    drop_table :corporate_bodies
    drop_table :works_corporate_bodies
    drop_table :expressions_corporate_bodies
    drop_table :manifestations_corporate_bodies
    drop_table :items_corporate_bodies
  end
end
