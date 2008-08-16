class Creation < ActiveRecord::Base

  # From the has_many_polymorphs gem.
  belongs_to :person
  belongs_to :creations, :polymorphic => :true

#  acts_as_double_polymorphic_join(
#    :creators => [:people],
#    :createds => [:works]
#  )

end
