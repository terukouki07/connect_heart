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
		image.variant(resize_to_fill: [width, height]).processed
  end

  #enumで状況ステータスの設定
  #里親募集中:0, トライアル中:1, 里親決定:2, 迷子動物捜索中:
  enum status: {recruiting: 0, trial: 1, decision: 2, lost_child: 3}

  #favoriteテーブルにcustomer_idが存在するかの真偽
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  #wordが完全一致したときpostテーブルからレコード取得。
  def self.looks(word)
  	@post = Post.where("name LIKE?", "#{word}")
  end

  #タグ検索
  def save_tag(tag_list)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags
    #古いタグを削除(更新時)
    old_tags.each do |old|
      target_tag = Tag.find_by(name: old)
      PostTag.find_by(post_id: self.id, tag_id: target_tag.id).delete

      target_tag = Tag.find_by(name: old)
      # 何件存在するか分かる
      target_tag_post_count = target_tag.posts.count 
      if target_tag_post_count == 0
        target_tag.delete
      end
    end
    #新しいタグをDBへ保存(新規登録時)
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags.push(new_post_tag)
    end
  end

  #バリデーション
  validates :name, presence: true, length: { maximum: 20 }
  validates :sex, presence: true
  validates :age, presence: true
  validates :body, presence: true, length: { maximum: 50 }
  validates :character, presence: true, length: { maximum: 50 }
  validates :status, presence: true
end
