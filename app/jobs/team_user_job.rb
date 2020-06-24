class TeamUserJob < ApplicationJob
  queue_as :default

  def perform team_user
    TeamUserMailer.new_invite(team_user).deliver_now!    
  end
end
