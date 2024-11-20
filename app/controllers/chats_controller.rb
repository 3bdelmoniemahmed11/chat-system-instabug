class ChatsController < ApplicationController
  def create
    app = Application.find_by!(token: params[:application_token])
    chat = app.chats.build
    if chat.save
      render json: { number: chat.number }, status: :created
    else
      render json: { errors: chat.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    app = Application.find_by!(token: params[:application_token])
    render json: app.chats
  end
end
