class CreateFrbrObjects < ActiveRecord::Migration
  def self.up
    create_table :frbr_objects do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :frbr_objects
  end
end
