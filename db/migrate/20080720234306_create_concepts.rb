class CreateConcepts < ActiveRecord::Migration
  def self.up
    create_table :concepts do |t|
      t.timestamps
      t.column :term, :string
      t.column :comment, :string
    end

  Concept.create :term => "love"
  Concept.create :term => "evil"
  
  end

  def self.down
    drop_table :concepts
  end
end
