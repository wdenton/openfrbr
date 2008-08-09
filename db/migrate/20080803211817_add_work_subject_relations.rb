class AddWorkSubjectRelations < ActiveRecord::Migration
  def self.up
    create_table :works_subjects_concepts, :id => false do |t|
      t.timestamps
      t.column :work_id, :integer
      t.column :concept_id, :integer
    end

    create_table :works_subjects_events, :id => false do |t|
      t.timestamps
      t.column :work_id, :integer
      t.column :event_id, :integer
    end

    create_table :works_subjects_objects, :id => false do |t|
      t.timestamps
      t.column :work_id, :integer
      t.column :frbr_object_id, :integer
    end

    create_table :works_subjects_places, :id => false do |t|
      t.timestamps
      t.column :work_id, :integer
      t.column :place_id, :integer
    end

  end

  def self.down
    drop_table :works_subjects_concepts
    drop_table :works_subjects_events
    drop_table :works_subjects_objects
    drop_table :works_subjects_places
  end
end
