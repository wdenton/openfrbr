class CreateProductions < ActiveRecord::Migration
  def self.up
    create_table :productions do |t|
      t.references :producer, :polymorphic => true
      t.references :manifestation
    end
    drop_table :manifestations_corporate_bodies
    drop_table :manifestations_people
  end

  def self.down
    drop_table :productions
  end
end
