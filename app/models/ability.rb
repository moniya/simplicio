class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    can :read, :all
    can :create, Answer

    if user.score >= VOTING_REP
      can :create, Vote
    end

    if user.score >= COMMENTING_REP
      can :create, Comment
    end
  end
end
