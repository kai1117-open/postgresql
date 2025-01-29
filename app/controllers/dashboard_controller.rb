class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tournaments = Tournament.includes(:participants).order(created_at: :desc)
  end
end