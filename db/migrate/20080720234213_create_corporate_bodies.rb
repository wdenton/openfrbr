class CreateCorporateBodies < ActiveRecord::Migration
  def self.up
    create_table :corporate_bodies do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :corporate_bodies
  end
end
