class Event < ActiveRecord::Base

  validates_presence_of :term, :message => "cannot be blank"

  has_many :works, :as => :subject

end
