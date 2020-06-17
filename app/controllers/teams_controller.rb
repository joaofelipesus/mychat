class TeamsController < ApplicationController

  def index
    @teams = current_user.my_teams
    authorize! :read, @teams
  end

end
