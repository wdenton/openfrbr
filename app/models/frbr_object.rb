class FrbrObject < ActiveRecord::Base

  has_and_belongs_to_many :works, :join_table => "works_subjects_objects"

end
