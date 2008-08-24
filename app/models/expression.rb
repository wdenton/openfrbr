class Expression < ActiveRecord::Base

  validates_length_of :title, :minimum => 1, 
   :message => "cannot be blank"

  belongs_to :work
  has_many :manifestations

  has_many_polymorphs :realizers, :from => [:people, :families, :corporate_bodies], :through => :realizations

end

