class Item < ActiveRecord::Base

  validates_presence_of :identifier, :message => "cannot be blank"
  validates_presence_of :call_number, :message => "cannot be blank"

  belongs_to :manifestation

  has_many_polymorphs :owners, :from => [:people, :families, :corporate_bodies], :through => :ownerships

  has_many :works, :as => :subject

  def anchor_text
    # TODO: Include manifestation title
    identifier + " (" + call_number + ")"
  end

end
