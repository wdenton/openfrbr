class Manifestation < ActiveRecord::Base

  validates_presence_of :title, :message => "cannot be blank"

  belongs_to :expression
  has_many :items

  has_many_polymorphs :producers, :from => [:people, :families, :corporate_bodies], :through => :productions

end
