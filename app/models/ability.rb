# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :read, Team do |team|
        user.my_teams.include?(team)
      end
      can :create, Team
      can :destroy, Team, owner_id: user.id
      can :create, Group do |group|
        group.owner_id == user.id
      end
    end
  end
end
