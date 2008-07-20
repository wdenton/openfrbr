class CreateManifestations < ActiveRecord::Migration
  def self.up
    create_table :manifestations do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :manifestations
  end
end
