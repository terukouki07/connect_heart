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
  
  #ゲストログイン
  GUEST_CUSTOMER_EMAIL = "guest@example.com"

  def self.guest
    #GUEST_CUSTOMER_EMAILがあればデータを返す、なければ、新規作成
    find_or_create_by!(email: GUEST_CUSTOMER_EMAIL) do |customer|
      #パスワードをランダムで作成
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲストユーザー"
    end
  end
  
  #バリデーション
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
end

