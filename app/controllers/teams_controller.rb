class TeamsController < ApplicationController

  def index
    @teams = current_user.my_teams
  end

  def create
    @team = Team.new team_params
    authorize! :create, @team
    if @team.save
      render json: { team: @team }, status: :created
    else
      render json: { errors: @team.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @team = Team.find params[:id]
    authorize! :destroy, @team
    if @team.destroy
      render json: {}, status: :ok
    else
      render json: { errors: @team.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def team_params
      params.require(:team).permit(:slug).merge(owner: current_user)
    end

end
