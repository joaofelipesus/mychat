class TeamUserMailer < ApplicationMailer

  def new_invite team_user
    @team_user = team_user
    mail(:to => @team_user.user.email, :subject => "You are invited to be a member of a new team !")
  end

end
