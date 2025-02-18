class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tournament
  before_action :set_match, only: [:show, :edit, :update]

  def index
    @matches = @tournament.matches.includes(player1: :user, player2: :user)
  end

  def show
  end

  def create
    participants = @tournament.participants.shuffle

    # すでに試合が組まれている場合はエラーを返す
    if @tournament.matches.exists?
      redirect_to tournament_matches_path(@tournament), alert: "既に試合が作成されています。"
      return
    end

    # スイスドロー方式で組み合わせを作成
    matches = []
    (0...participants.length).step(2) do |i|
      break if i + 1 >= participants.length
      matches << Match.create!(
        tournament: @tournament,
        player1: participants[i],
        player2: participants[i + 1],
        round: 1
      )
    end

    redirect_to tournament_matches_path(@tournament), notice: "試合が作成されました。"
  end

  def edit
  end

  def update
    if @match.update(match_params)
      update_scores(@match)
      redirect_to tournament_matches_path(@tournament), notice: "試合結果を登録しました。"
    else
      render :edit
    end
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end

  def set_match
    @match = @tournament.matches.find(params[:id])
  end

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
