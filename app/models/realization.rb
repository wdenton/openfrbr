class Realization < ActiveRecord::Base

  belongs_to :expression
  belongs_to :realizers, :polymorphic => true

end
