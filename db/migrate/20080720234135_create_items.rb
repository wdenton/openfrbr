class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.timestamps
      t.column :call_number, :string
      t.column :identifier, :string
      t.column :provenance, :string
      t.column :marks, :string
      t.column :condition, :string
      t.column :comment, :string
      t.column :manifestation_id, :integer
    end

    Item.create :call_number => "FIC ROW", :identifier => "My copy", :comment => "", :manifestation_id => 1
    Item.create :call_number => "YA ROWLING", :identifier => "My copy", :comment => "", :manifestation_id => 2
    Item.create :call_number => "PR 6068 O93 H322 1999", :identifier => "My copy", :comment => "", :manifestation_id => 3

  end

  def self.down
    drop_table :items
  end
end
