class TournamentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params[:id])
    @participants = @tournament.participants.includes(:user).order(score: :desc)
    @matches = @tournament.matches.where(round: @tournament.current_round)
  end
  
  def previous_round
    @tournament = Tournament.find(params[:id])
    @tournament.update(current_round: @tournament.current_round - 1)
  
    redirect_to tournament_matches_path(@tournament), notice: "前のラウンドへ戻りました！"
  end

  def next_round
    @tournament = Tournament.find(params[:id])
    @tournament.update(current_round: @tournament.current_round + 1)
  
    redirect_to tournament_matches_path(@tournament), notice: "次のラウンドへ進みました！"
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

  def join
    @tournament = Tournament.find(params[:id])
    
    # 既に参加済みかチェック
    if @tournament.participants.exists?(user: current_user)
      redirect_to @tournament, alert: "既に参加しています。"
      return
    end

    # 参加者が定員オーバーでないかチェック
    if @tournament.participants.count >= @tournament.max_participants
      redirect_to @tournament, alert: "参加人数が上限に達しました。"
      return
    end

    # 参加登録
    @tournament.participants.create(user: current_user, score: 0)

    redirect_to @tournament, notice: "大会に参加しました！"
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :date, :max_participants, :status)
  end
end
