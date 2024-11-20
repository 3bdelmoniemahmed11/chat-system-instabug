class MessagesController < ApplicationController
  def create
    chat = Chat.joins(:application).find_by!(applications: { token: params[:application_token] }, number: params[:chat_number])
    message = chat.messages.build(message_params)
    if message.save
      render json: { number: message.number }, status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def search
    chat = Chat.joins(:application).find_by!(applications: { token: params[:application_token] }, number: params[:chat_number])
    results = Elasticsearch::Model.search(params[:query], chat.messages)
    render json: results.records.to_a
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
