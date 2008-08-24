class CorporateBody < ActiveRecord::Base

  validates_length_of :name, :minimum => 1, 
   :message => "cannot be blank"

  has_many :works,          :as => :creator
  has_many :expressions,    :as => :realizer
  has_many :manifestations, :as => :producer
  has_many :items,          :as => :owner

end
