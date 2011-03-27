class CreateOwnerships < ActiveRecord::Migration
  def self.up
    create_table :ownerships do |t|
      t.references :owner, :polymorphic => true
      t.references :item
    end
    drop_table :items_corporate_bodies
    drop_table :items_people
  end

  def self.down
    drop_table :ownerships
  end
end
