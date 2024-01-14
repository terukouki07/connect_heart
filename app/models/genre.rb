class Genre < ApplicationRecord
  has_many :posts, dependent: :destroy
  
  #バリデーション
  validates :name, presence: true
end
