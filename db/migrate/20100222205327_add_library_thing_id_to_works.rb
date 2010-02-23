class AddLibraryThingIdToWorks < ActiveRecord::Migration
  def self.up
    add_column :works, :libraryThing_id, :int
  end

  def self.down
    remove_column :works, :libraryThing_id
  end
end
