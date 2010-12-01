class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
    
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :create, Comment
      can :update, Comment do |comment|
        comment.try(:user) == user
      end
    end
  end
end