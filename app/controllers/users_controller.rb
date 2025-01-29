class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @participations = @user.participants.includes(:tournament)
  end
end