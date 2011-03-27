class Item < ActiveRecord::Base

  validates_presence_of :identifier, :message => "cannot be blank"
  validates_presence_of :call_number, :message => "cannot be blank"

  has_one :exemplification
  has_one :manifestation, :through => :exemplifications

  has_many_polymorphs :owners, :from => [:people, :families, :corporate_bodies], :through => :ownerships

  has_many :works, :as => :subject

  def anchor_text
    # TODO: Include manifestation title
    identifier + " (" + call_number + ")"
  end

  def manifestation
    # Return the manifestation which an item exemplifies
    Manifestation.find(exemplification.manifestation_id)
  end

end
