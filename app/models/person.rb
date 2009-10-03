class Person < ActiveRecord::Base

  validates_presence_of :name, :message => "cannot be blank"

  has_many :works,          :as => :creator
  has_many :expressions,    :as => :realizer
  has_many :manifestations, :as => :producer
  has_many :items,          :as => :owner

  has_many :works,          :as => :subject

  def anchor_text
    name + " (" + creations.size.to_s + " w)"
  end

end
