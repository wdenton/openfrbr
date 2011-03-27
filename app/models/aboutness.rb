class Aboutness < ActiveRecord::Base

  belongs_to :work
  belongs_to :subjects, :polymorphic => true

end
