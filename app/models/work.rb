class Work < ActiveRecord::Base

  validates_presence_of :title, :message => "cannot be blank"

  has_many :reifications
  has_many :expressions, :through => :reifications

  has_many_polymorphs :creators, :from => [:people, :families, :corporate_bodies], :through => :creations
  has_many_polymorphs :subjects, :from => [:expressions, :manifestations, :items, :people, :families, :corporate_bodies, :concepts, :events, :frbr_objects, :places], :through => :aboutnesses

end
