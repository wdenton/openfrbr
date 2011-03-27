class CreateCreations < ActiveRecord::Migration
  def self.up
    create_table :creations do |t|
      t.references :creator, :polymorphic => true
      t.references :work
    end
    drop_table :works_corporate_bodies
    drop_table :works_people
  end

  def self.down
    drop_table :creations
  end
end
