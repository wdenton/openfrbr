class CreateCreations < ActiveRecord::Migration
  def self.up
    create_table :creations do |t|
      t.references :person, :polymorphic => :true
      t.references :work, :polymorhic => :tre	
    end
  end

  def self.down
    drop_table :creations
  end
end
