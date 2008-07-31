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

    CorporateBody.create :name => "Raincoast Books", :dates => "", :place => "Vancouver, BC", :comment => ""
    CorporateBody.create :name => "Arthur A. Levine", :dates => "", :place => "USA", :comment => ""
    CorporateBody.create :name => "Listening Library", :dates => "", :place => "", :comment => ""

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
   
    # Raincoast Books published the manifestations of the first three books
    Manifestation.find(1).corporate_bodies << CorporateBody.find(1)
    Manifestation.find(2).corporate_bodies << CorporateBody.find(1)
    Manifestation.find(3).corporate_bodies << CorporateBody.find(1)

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
