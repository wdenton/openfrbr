class Item < ActiveRecord::Base

  belongs_to :manifestation

  has_many_polymorphs :owners, :from => [:people, :families, :corporate_bodies], :through => :ownerships

end
