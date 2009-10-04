class Manifestation < ActiveRecord::Base

  validates_presence_of :title, :message => "cannot be blank"
  validates_presence_of :form_of_carrier, :message => "cannot be blank"
  validates_presence_of :identifier, :message => "cannot be blank"

  belongs_to :expression
  has_many :items

  has_many_polymorphs :producers, :from => [:people, :families, :corporate_bodies], :through => :productions

  has_many :works, :as => :subject

  def anchor_text
    title + " (" + form_of_carrier + ", " + identifier + ", " + items.size.to_s + ")"
  end

end
