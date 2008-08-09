class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.timestamps
      t.column :call_number, :string
      t.column :identifier, :string
      t.column :provenance, :string
      t.column :comment, :string
      t.column :manifestation_id, :integer
    end
  end

  def self.down
    drop_table :items
  end
end
