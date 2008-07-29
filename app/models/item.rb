class Item < ActiveRecord::Base

  belongs_to :manifestation
  has_and_belongs_to_many :people, :join_table => "items_people"
  has_and_belongs_to_many :corporate_bodies, :join_table => "items_corporate_bodies"

end
