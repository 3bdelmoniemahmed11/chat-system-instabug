class ApplicationsController < ApplicationController
  def create
    app = Application.new(application_params)
    if app.save
      render json: { token: app.token, name: app.name }, status: :created
    else
      render json: { errors: app.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    apps = Application.all
    render json: apps
  end

  private

  def application_params
    params.require(:application).permit(:name)
  end
end
