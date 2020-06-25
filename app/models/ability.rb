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
      can :destroy, Group do |group|
        group.owner_id == user.id
      end
      can :create, TeamUser do |team_user|
        team_user.team.owner_id == user.id
      end
      can [:destroy, :update], TeamUser do |team_user|
        team_user.user == user and team_user.pending?
      end
      can :read, TeamUser do |team_user|
        team_user.user == user
      end
      can [:create, :read], Message do |message|
        user.my_teams.include? message.group.team
      end
    end
  end
end
