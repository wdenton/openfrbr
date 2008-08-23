class Ownership < ActiveRecord::Base

  belongs_to :item
  belongs_to :owners, :polymorphic => true

end
