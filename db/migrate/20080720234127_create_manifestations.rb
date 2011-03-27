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

  end

  def self.down
    drop_table :manifestations
  end
end
