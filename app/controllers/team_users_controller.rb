class TeamUsersController < ApplicationController

  def create
    @team_user = TeamUser.new team_user_params
    authorize! :create, @team_user
    if @team_user.save
      render json: { team_user: @team_user }, status: :created
    else
      render json: { errors: @team_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @team_user = TeamUser.find params[:id]
    authorize! :destroy, @team_user
    if @team_user.destroy
      render json: {}, status: :ok
    else
      render json: { errors: @team_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def team_user_params
      params.require(:team_user).permit(:team_id, :user_id)
    end

end
