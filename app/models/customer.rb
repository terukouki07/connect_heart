class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :customer_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  #ActiveStorage(画像)
  has_one_attached :profile_image
  
  def get_profile_image(width, height)
    #profile_imageが空でないかの条件分岐
    unless profile_image.attached?
    #空だった場合、no_image.jpgを使用
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    #画像のリサイズを設定
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #searchの条件分岐
  #perfect_match=>完全一致, forward_match=>前方一致, backward_match=>後方一致, partial_match=>部分一致
  def self.looks(search, word)
    if search == "perfect_match"
      @customer = Customer.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @customer = Customer.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @customer = Customer.where("name LIKE?", "%#{word}")
    elsif search == "partial_match"
      @customer = Customer.where("name LIKE?", "%#{word}%")
    else
      @customer = Customer.all
    end
  end
end

