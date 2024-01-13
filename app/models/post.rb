class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  #ActiveStorage(画像)
  has_one_attached :image

  def get_image(width, height)
    #imageが空でないかの条件分岐
	  unless image.attached?
	  #空だった場合、no_image.jpgを使用
	    file_path = Rails.root.join('app/assets/images/no_image.jpg')
	    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
	  end
	  #画像のリサイズを指定。
		image.variant(resize_to_limit: [width, height]).processed
  end

  #enumで状況ステータスの設定
  #里親募集中:0, トライアル中:1, 里親決定:2, 迷子動物捜索中:
  enum status: {recruiting: 0, trial: 1, decision: 2, lost_child: 3}

  #favoriteテーブルにcustomer_idが存在するかの真偽
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  #searchの条件分岐
  #perfect_match=>完全一致, forward_match=>前方一致, backward_match=>後方一致, partial_match=>部分一致
  def self.looks(search, word)
    if search == "perfect_match"
      @psot = Post.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @post = Post.where("name LIKE?", "%#{word}")
    elsif search == "partial_match"
      @post = Post.where("name LIKE?", "%#{word}%")
    else
      @post = Post.all
    end
  end
end
