class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.timestamps
      t.column :term, :string
      t.column :comment, :string
    end
    
    Place.create :term => "Platform 9 3/4, King's Cross Station"
    Place.create :term => "Number 4, Privet Drive, Little Whinging, Surrey, England"
    
  end

  def self.down
    drop_table :places
  end
end
