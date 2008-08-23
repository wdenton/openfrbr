class Person < ActiveRecord::Base

  has_many :creations
  has_many :works, :through => :creations

  has_many :expressions, :as => :realizer
  has_many :items,       :as => :owner

end
