class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
end
