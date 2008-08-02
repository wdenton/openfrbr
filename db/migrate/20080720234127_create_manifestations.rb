class CreateManifestations < ActiveRecord::Migration
  def self.up
    create_table :manifestations do |t|
      t.timestamps
      t.column :title, :string
      t.column :statement_of_responsibility, :string
      t.column :edition, :string
      t.column :identifier, :string
      t.column :form_of_carrier, :string
      t.column :publisher, :string
      t.column :publication_date, :string
      t.column :publication_place, :string
      t.column :series_statement, :string
      t.column :comment, :string
      t.column :expression_id,  :integer # foreign key for the expression
    end

    Manifestation.create :title => "Harry Potter and the Philosopher's Stone", :edition => "", :identifier => "1551923963", :form_of_carrier => "hardcover", :publisher => "Raincoast Books", :publication_date => "2000", :comment => "", :expression_id => 1
    Manifestation.create :title => "Harry Potter and the Chamber of Secrets", :edition => "", :identifier => "1551922444", :form_of_carrier => "hardcover", :publisher => "Raincoast Books", :publication_date => "1999", :comment => "", :expression_id => 2
    Manifestation.create :title => "Harry Potter and the Prisoner of Azkaban", :edition => "", :identifier => "1551922460", :form_of_carrier => "hardcover", :publisher => "Raincoast Books", :publication_date => "1999", :comment => "", :expression_id => 3

  end

  def self.down
    drop_table :manifestations
  end
end
