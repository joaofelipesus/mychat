class GroupsController < ApplicationController

  def create
    @group = Group.new group_params
    authorize! :create, @group
    if @group.save
      render json: { group: @group }, status: :created
    else
      render json: { errors: @group.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def group_params
      params.require(:group).permit(:slug, :team_id).merge(owner: current_user)
    end

end
