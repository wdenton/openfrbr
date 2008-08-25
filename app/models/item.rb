class Item < ActiveRecord::Base

  validates_presence_of :identifier, :message => "cannot be blank"

  belongs_to :manifestation

  has_many_polymorphs :owners, :from => [:people, :families, :corporate_bodies], :through => :ownerships

end
