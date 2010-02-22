class AddLibraryThingIdToWorks < ActiveRecord::Migration
  def self.up
    add_column :works, :libraryThingId, :int
  end

  def self.down
    remove_column :works, :libraryThingId
  end
end
