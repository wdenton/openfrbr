class Person < ActiveRecord::Base

  has_many :works,       :as => :creator
  has_many :expressions, :as => :realizer
  has_many :items,       :as => :owner

end
