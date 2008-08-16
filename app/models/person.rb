class Person < ActiveRecord::Base

  #has_many :works, :through => :creators
  #has_many :creators

  has_many_polymorphs :createds, :from => [:works], :through =>  :creations

  #has_and_belongs_to_many :works, :join_table => "works_people"
  has_and_belongs_to_many :expressions, :join_table => "expressions_people"
  has_and_belongs_to_many :manifestations, :join_table => "manifestations_people"
  has_and_belongs_to_many :items, :join_table => "items_people"

end
