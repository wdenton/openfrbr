class CreateConcepts < ActiveRecord::Migration
  def self.up
    create_table :concepts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :concepts
  end
end
