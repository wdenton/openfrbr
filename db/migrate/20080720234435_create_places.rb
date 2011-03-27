class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.timestamps
      t.column :term, :string
      t.column :comment, :string
    end
  end

  def self.down
    drop_table :places
  end
end
