class Work < ActiveRecord::Base

  validates_presence_of :title, :message => "cannot be blank"
  validates_presence_of :form, :message => "cannot be blank"

  has_many :reifications
  has_many :expressions, :through => :reifications

  has_many_polymorphs :creators, :from => [:people, :families, :corporate_bodies], :through => :creations
  has_many_polymorphs :subjects, :from => [:expressions, :manifestations, :items, :people, :families, :corporate_bodies, :concepts, :events, :frbr_objects, :places], :through => :aboutnesses

  def anchor_text
    # title + " (" + form + "/" + reifications.size.to_s + ")"
    title + " (" + form + ", " + reifications.size.to_s + " e)"
  end

 # Sort Works by anchor text.  Useful for displaying in lists.
 # Could also sort by title and then number of expressions.  Hmm.
 def <=>(o) 
   self.anchor_text.downcase <=> o.anchor_text.downcase
 end

end
