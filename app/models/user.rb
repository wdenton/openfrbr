class User < ActiveRecord::Base

  acts_as_authentic do |c|
    # see documentation in: Authlogic::ActsAsAuthentic
    # c.validate_email_field = true
  end

end
