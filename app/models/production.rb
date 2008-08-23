class Production < ActiveRecord::Base

  belongs_to :manifestation
  belongs_to :producers, :polymorphic => true

end
