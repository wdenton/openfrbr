class CreateFamilies < ActiveRecord::Migration
  def self.up
    create_table :families do |t|
      t.timestamps
      t.column :name, :string
      t.column :type, :string
      t.column :dates, :string
      t.column :places, :string
      t.column :history, :string
    end
    
  Family.create :name => "Potter family"
  Family.create :name => "Dursley family"
    
  end
  
  def self.down
    drop_table :families
  end
end
