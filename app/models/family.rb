class Family < ActiveRecord::Base

  has_many :expressions, :as => :realizer
  has_many :items,       :as => :owner

end
