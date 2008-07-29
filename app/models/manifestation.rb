class Manifestation < ActiveRecord::Base

  belongs_to :expression
  has_many :items
  has_and_belongs_to_many :people, :join_table => "manifestations_people"
  has_and_belongs_to_many :corporate_bodies, :join_table => "manifestations_corporate_bodies"

end
