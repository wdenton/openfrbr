class Manifestation < ActiveRecord::Base

  validates_presence_of :title, :message => "cannot be blank"
  # validates_presence_of :form_of_carrier, :message => "cannot be blank"
  validates_presence_of :identifier, :message => "cannot be blank"

  has_many :embodiments
  has_many :expressions, :through => :embodiments

  has_many :exemplifications
  has_many :items, :through => :exemplifications

  has_many_polymorphs :producers, :from => [:people, :families, :corporate_bodies], :through => :productions

  has_many :works, :as => :subject

  def anchor_text
    # Used to have form_of_carrier in here, to disambiguate
    title + " (" + identifier + ", " + exemplifications.size.to_s + ")"
  end

end
