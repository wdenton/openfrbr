class CreateRealizations < ActiveRecord::Migration
  def self.up
    add_column :expressions, :realizer_id, :integer
    add_column :expressions, :realizer_type, :string
  end

  def self.down
    remove_column :expressions, :realizer_id
    remove_column :expressions, :realizer_type
  end
end
