class Work < ActiveRecord::Base

  has_many :expressions
  has_and_belongs_to_many :people, :join_table => "works_people"
  has_and_belongs_to_many :corporate_bodies, :join_table => "works_corporate_bodies"

end
