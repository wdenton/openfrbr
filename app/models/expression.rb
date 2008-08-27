class Expression < ActiveRecord::Base

  validates_presence_of :title, :message => "cannot be blank"
  validates_presence_of :language, :message => "cannot be blank"
  validates_presence_of :form, :message => "cannot be blank"

  has_many :reifications
  has_many :works, :through => :reifications

  has_many :manifestations

  has_many_polymorphs :realizers, :from => [:people, :families, :corporate_bodies], :through => :realizations

  has_many :works, :as => :subject

  def anchor_text
    title + " (" + language + ", " + form + ")"
  end

end

