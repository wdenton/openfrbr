class AddRelationAttributeToG1G2Relation < ActiveRecord::Migration
  def self.up
    add_column :creations, :relation, :string
    add_column :realizations, :relation, :string
    add_column :productions, :relation, :string
    add_column :ownerships, :relation, :string
  end

  def self.down
    remove_column :creations, :relation
    remove_column :realizations, :relation
    remove_column :productions, :relation
    remove_column :ownerships, :relation
  end
end
