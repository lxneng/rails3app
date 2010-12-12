class User < ActiveRecord::Base
  acts_as_authentic
  has_many :articles
  has_many :comments
  
  def self.find_by_login_or_email(login)
    User.find_by_login(login) || User.find_by_email(login)
  end
  
  def deliver_password_reset_instructions!
     reset_perishable_token!
     Notifier.deliver_password_reset_instructions(self)
  end
  
end
