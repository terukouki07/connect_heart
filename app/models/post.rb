class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy

  #ActiveStorage(画像)
  has_one_attached :image

  def get_image(width, height)
    #imageが空でないかの条件分岐
	  unless image.attached?
	  #空だった場合、no_image.jpgを使用
	    file_path = Rails.root.join('app/assets/images/no_image.jpg')
	    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
	  end
	  #画像のリサイズを
		image.variant(resize_to_limit: [width, height]).processed
  end

  #enumで状況ステータスの設定
  #里親募集中:0, トライアル中:1, 里親決定:2, 迷子動物探し中:
  enum status: {recruiting: 0, trial: 1, decision: 2, lost_child: 3}
  
  #favoriteテーブルにcustomer_idが存在するかの真偽
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
end
