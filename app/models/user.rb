class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         
          has_many :posts, dependent: :destroy
          has_many :comments, dependent: :destroy
          has_many :favorites, dependent: :destroy

  ## フォローする側のUserが持つRelationship
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 自分がフォローしているUserを取得するためのアソシエーション
  has_many :followings, through: :active_relationships, source: :followed

  ## フォローされる側のUserが持つRelationship
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分をフォローしているUserを取得するためのアソシエーション
  has_many :followers, through: :passive_relationships, source: :follower

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates:introduction, length:{maximum: 100}
  
    ## ゲストログイン方法
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |end_user|
      end_user.name = 'ゲスト'
      end_user.password = SecureRandom.urlsafe_base64  #パスワードはランダムな文字列
    end
  end

  ## 会員のキーワード検索
  def self.search(keyword)
    if keyword.present?
      where(['name LIKE ?', "%#{keyword}%"])
    else
      none  #キーワードがない場合はフラッシュメッセージを表示して結果を返さない
    end
  end

  ## フォローしたときの処理  
  def follow(end_user)
    active_relationships.create(followed_id: end_user.id)
  end

  ## フォローを外すときの処理
  def unfollow(end_user)
    active_relationships.find_by(followed_id: end_user.id).destroy
  end

  ## フォローしているか判定
  def following?(end_user)
    followings.include?(end_user)
  end
end
