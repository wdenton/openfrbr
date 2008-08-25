class Concept < ActiveRecord::Base

  validates_presence_of :term, :message => "cannot be blank"

  has_and_belongs_to_many :works, :join_table => "works_subjects_concepts"

end
