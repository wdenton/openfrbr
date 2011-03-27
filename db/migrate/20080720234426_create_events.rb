class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.timestamps
      t.column :term, :string
      t.column :date, :string
      t.column :comment, :string
    end
  end

  def self.down
    drop_table :events
  end
end
