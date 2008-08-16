class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.timestamps
      t.integer :entity_id
      t.integer :entity_type
      t.integer :subject_id
      t.
    end

    drop_table :work_subjects_concepts
    drop_table :work_subjects_events
    drop_table :work_subjects_frbr_objects
    drop_table :work_subjects_places
  end

  def self.down
    drop_table :subjects
  end
end
