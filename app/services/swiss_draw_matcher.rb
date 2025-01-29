class SwissDrawMatcher
  def initialize(tournament, round)
    @tournament = tournament
    @round = round
  end

  def call
    participants = @tournament.participants.order(score: :desc)
    matches = []

    while participants.size > 1
      player1 = participants.shift
      player2 = participants.find { |p| !already_played?(player1, p) }
      next unless player2

      participants.delete(player2)
      matches << Match.create!(
        tournament: @tournament,
        player1: player1,
        player2: player2,
        round: @round
      )
    end

    matches
  end

  private

  def already_played?(player1, player2)
    player1.matches.any? { |m| m.player1 == player2 || m.player2 == player2 }
  end
end