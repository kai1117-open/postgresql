class TournamentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to @tournament, notice: '大会を作成しました。'
    else
      render :new
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :date, :max_participants, :status)
  end
end