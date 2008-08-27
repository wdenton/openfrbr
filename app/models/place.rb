class Place < ActiveRecord::Base

  validates_presence_of :term, :message => "cannot be blank"

  has_many :works, :as => :subject

  def anchor_text
    term
  end

end
