class Concept < ActiveRecord::Base

  has_and_belongs_to_many :works, :join_table => "works_subjects_concepts"

end
