class CreateRealizations < ActiveRecord::Migration
  def self.up
    create_table :realizations do |t|
      t.references :realizer, :polymorphic => true
      t.references :expression
    end
    drop_table :expressions_corporate_bodies
    drop_table :expressions_people
  end

  def self.down
    drop_table :realizations
  end
end
