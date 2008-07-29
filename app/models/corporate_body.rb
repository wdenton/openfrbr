class CorporateBody < ActiveRecord::Base

  has_and_belongs_to_many :works,          :join_table => "works_corporates"
  has_and_belongs_to_many :expressions,    :join_table => "expressions_corporates"
  has_and_belongs_to_many :manifestations, :join_table => "manifestations_corporates"
  has_and_belongs_to_many :items,          :join_table => "items_corporates"

end
