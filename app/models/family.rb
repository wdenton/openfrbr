class Family < ActiveRecord::Base

  validates_presence_of :name, :message => "cannot be blank"

  has_many :works,          :as => :creator
  has_many :expressions,    :as => :realizer
  has_many :manifestations, :as => :producer
  has_many :items,          :as => :owner

  has_many :works,          :as => :subject

end
