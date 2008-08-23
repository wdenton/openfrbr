class Creation < ActiveRecord::Base

  belongs_to :work
  belongs_to :creators, :polymorphic => true

end
