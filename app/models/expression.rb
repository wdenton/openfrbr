class Expression < ActiveRecord::Base

  belongs_to :work
  has_many :manifestations

  belongs_to :realizer, :polymorphic => true

  #has_and_belongs_to_many :people, :join_table => "expressions_people"
  #has_and_belongs_to_many :corporate_bodies, :join_table => "expressions_corporate_bodies"

end

