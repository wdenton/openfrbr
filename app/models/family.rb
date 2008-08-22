class Family < ActiveRecord::Base

  has_many :expressions, :as => :realizer

end
