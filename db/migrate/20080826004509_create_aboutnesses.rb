class CreateAboutnesses < ActiveRecord::Migration
  def self.up
    create_table :aboutnesses do |t|
      t.references :subject, :polymorphic => true
      t.references :work
    end
    drop_table :works_subjects_concepts
    drop_table :works_subjects_events
    drop_table :works_subjects_objects
    drop_table :works_subjects_places
  end

  def self.down
    drop_table :aboutness
  end
end
