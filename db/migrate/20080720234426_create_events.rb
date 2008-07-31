class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.timestamps
      t.column :term, :string
      t.column :comment, :string
    end

  Event.create :term => "Death of James and Lily Potter"
  Event.create :term => "Sirius Black's escape from Azkaban"
  
  end

  def self.down
    drop_table :events
  end
end
