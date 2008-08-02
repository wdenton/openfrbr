class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.timestamps
      t.column :term, :string
      t.column :date, :string
      t.column :comment, :string
    end
    
    Event.create :term => "Death of James and Lily Potter", :date => "31 October 1981"
    Event.create :term => "Birth of Harry Potter", :date => "31 July 1980"
    Event.create :term => "Harry Potter begins at Hogwarts", :date => "September 1991"
    
  end

  def self.down
    drop_table :events
  end
end
