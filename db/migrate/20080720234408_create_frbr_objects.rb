class CreateFrbrObjects < ActiveRecord::Migration
  def self.up
    create_table :frbr_objects do |t|
      t.timestamps
      t.column :term, :string
      t.column :comment, :string
    end

  FrbrObject.create :term => "wand", :comment => ""
  FrbrObject.create :term => "philosopher's stone", :comment => ""
  
  end

  def self.down
    drop_table :frbr_objects
  end
end
