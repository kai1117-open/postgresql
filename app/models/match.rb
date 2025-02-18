class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :player1, class_name: "Participant", foreign_key: "player1_id"
  belongs_to :player2, class_name: "Participant", foreign_key: "player2_id"
end
