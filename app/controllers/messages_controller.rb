class MessagesController < ApplicationController

  def create
    @message = Message.new message_params
    authorize! :create, @message
    if @message.save
      render json: { message: @message }, status: :created
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def message_params
      params.require(:message).permit(:body, :group_id).merge(user: current_user)
    end

end
