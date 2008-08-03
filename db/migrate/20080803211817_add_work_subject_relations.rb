class AddWorkSubjectRelations < ActiveRecord::Migration
  def self.up
    create_table :works_subjects_concepts, :id => false do |t|
      t.timestamps
      t.column :work_id, :integer
      t.column :concept_id, :integer
    end
    # Love and evil are subjects of all the books
    Work.find(1).concepts << Concept.find(1)
    Work.find(2).concepts << Concept.find(1)
    Work.find(3).concepts << Concept.find(1)
    Work.find(1).concepts << Concept.find(2)
    Work.find(2).concepts << Concept.find(2)
    Work.find(3).concepts << Concept.find(2)

    create_table :works_subjects_events, :id => false do |t|
      t.timestamps
      t.column :work_id, :integer
      t.column :event_id, :integer
    end
    # Three initial test events all mentioned in first book
    Work.find(1).events << Event.find(1)
    Work.find(1).events << Event.find(2)
    Work.find(1).events << Event.find(3)

    create_table :works_subjects_objects, :id => false do |t|
      t.timestamps
      t.column :work_id, :integer
      t.column :frbr_object_id, :integer
    end
    # Wand and Sorting Hat in all three, butterbeer in third
    Work.find(1).frbr_objects << FrbrObject.find(1)
    Work.find(2).frbr_objects << FrbrObject.find(1)
    Work.find(3).frbr_objects << FrbrObject.find(1)
    Work.find(1).frbr_objects << FrbrObject.find(2)
    Work.find(2).frbr_objects << FrbrObject.find(2)
    Work.find(3).frbr_objects << FrbrObject.find(2)
    Work.find(3).frbr_objects << FrbrObject.find(3)

    create_table :works_subjects_places, :id => false do |t|
      t.timestamps
      t.column :work_id, :integer
      t.column :place_id, :integer
    end
    # Dursley home and Platform 9 3/4 in all three books
    Work.find(1).places << Place.find(1)
    Work.find(1).places << Place.find(2)
    Work.find(2).places << Place.find(1)
    Work.find(2).places << Place.find(2)
    Work.find(3).places << Place.find(1)
    Work.find(3).places << Place.find(2)

  end

  def self.down
    drop_table :works_subjects_concepts
    drop_table :works_subjects_events
    drop_table :works_subjects_objects
    drop_table :works_subjects_places
  end
end
