class Chat < ApplicationRecord
  belongs_to :customer
  belongs_to :room
  
  #バリデーション
  validates :message, presence: true, length: { in: 1..100 }
end
