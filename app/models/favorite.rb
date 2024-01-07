class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  
  #いいねの重複を防止
  validates :customer_id, uniqueness: {scope: :post_image_id} 
end
