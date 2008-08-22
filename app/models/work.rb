class Work < ActiveRecord::Base

  has_many :expressions

  has_many :creations
  has_many :people, :through => :creations
 
  # has_and_belongs_to_many :people, :join_table => "works_people"
  #has_and_belongs_to_many :corporate_bodies, :join_table => "works_corporate_bodies"

  has_and_belongs_to_many :concepts, :join_table => "works_subjects_concepts"
  has_and_belongs_to_many :events, :join_table => "works_subjects_events"
  has_and_belongs_to_many :frbr_objects, :join_table => "works_subjects_objects"
  has_and_belongs_to_many :places, :join_table => "works_subjects_places"

end
