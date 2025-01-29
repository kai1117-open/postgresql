class MatchesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    if @match.update(match_params)
      update_scores(@match)
      redirect_to @match.tournament, notice: "試合結果を登録しました。"
    else
      render :edit
    end
  end

  private

  def match_params
    params.require(:match).permit(:result)
  end

  def update_scores(match)
    case match.result
    when "player1"
      match.player1.increment!(:score, 3)
    when "player2"
      match.player2.increment!(:score, 3)
    when "draw"
      match.player1.increment!(:score, 1)
      match.player2.increment!(:score, 1)
    end
  end
end