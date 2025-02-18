class Tournament < ApplicationRecord
  has_many :participants
  has_many :matches, dependent: :destroy  # ✅ 追加
end
