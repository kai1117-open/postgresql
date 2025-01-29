class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @users = User.all
  end

  private

  def check_admin
    redirect_to root_path, alert: "管理者のみアクセス可能" unless current_user.admin?
  end
end