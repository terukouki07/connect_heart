class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post

  #バリデーション
  validates :comment, presence: true, length: { in: 1..100 }
end
