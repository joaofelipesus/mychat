# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :read, Team do |team|
        user.my_teams.include?(team)
      end
    end
  end
end
