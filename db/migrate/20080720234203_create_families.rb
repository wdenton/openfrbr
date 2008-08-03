class CreateFamilies < ActiveRecord::Migration
  def self.up
    create_table :families do |t|
      t.timestamps
      t.column :name, :string
      t.column :family_type, :string
      t.column :dates, :string
      t.column :places, :string
      t.column :history, :string
      t.column :comment, :string
    end

  Family.create :name => "Potter family", :places => ""
  Family.create :name => "Dursley family", :places => ""

  end

  def self.down
    drop_table :families
  end
end
