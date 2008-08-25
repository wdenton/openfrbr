class Manifestation < ActiveRecord::Base

  validates_length_of :title, :minimum => 1, 
   :message => "cannot be blank"

  belongs_to :expression
  has_many :items

  has_many_polymorphs :producers, :from => [:people, :families, :corporate_bodies], :through => :productions

end
