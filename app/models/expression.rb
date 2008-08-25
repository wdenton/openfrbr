class Expression < ActiveRecord::Base

  validates_presence_of :title, :message => "cannot be blank"

  belongs_to :work
  has_many :manifestations

  has_many_polymorphs :realizers, :from => [:people, :families, :corporate_bodies], :through => :realizations

end

