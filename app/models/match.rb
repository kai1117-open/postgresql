class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :player1, class_name: "Participant"
  belongs_to :player2, class_name: "Participant"
end
