class Work < ActiveRecord::Base

  validates_presence_of :title, :message => "cannot be blank"

  has_many :expressions

  has_many_polymorphs :creators, :from => [:people, :families, :corporate_bodies], :through => :creations

  has_and_belongs_to_many :concepts, :join_table => "works_subjects_concepts"
  has_and_belongs_to_many :events, :join_table => "works_subjects_events"
  has_and_belongs_to_many :frbr_objects, :join_table => "works_subjects_objects"
  has_and_belongs_to_many :places, :join_table => "works_subjects_places"

end
