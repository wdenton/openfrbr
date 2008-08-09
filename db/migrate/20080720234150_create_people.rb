class CreatePeople < ActiveRecord::Migration
  def self.up 
    create_table :people do |t|
      t.timestamps
      t.column :name, :string
      t.column :dates, :string
      t.column :title, :string
      t.column :other_designation, :string
      t.column :affiliation, :string
      t.column :country, :string
      t.column :comment, :string
    end

    create_table :works_people, :id => false do |t|
      t.timestamps
      t.column :work_id, :integer
      t.column :person_id, :integer
    end

    create_table :expressions_people, :id => false do |t|
      t.timestamps
      t.column :expression_id, :integer
      t.column :person_id, :integer
    end

    create_table :manifestations_people, :id => false do |t|
      t.timestamps
      t.column :manifestation_id, :integer
      t.column :person_id, :integer
    end

    create_table :items_people, :id => false do |t|
      t.timestamps
      t.column :item_id, :integer
      t.column :person_id, :integer
    end

  end

  def self.down
    drop_table :people
    drop_table :works_people
    drop_table :expressions_people
    drop_table :manifestations_people
    drop_table :items_people
  end
end
