class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         
          has_many :posts, dependent: :destroy
          has_many :comments, dependent: :destroy
          has_many :favorites, dependent: :destroy

  # foreign_keyで参照するカラムを指定
  # relationshipsとreverse_of_relationshipsは、わかりにくいため名前をつけているだけ
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # user.followersとuser.followingsという記述でフォロワーを表示したいので、throughでスルーするテーブル、sourceで参照するカラムを指定
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates:introduction, length:{maximum: 100}
end
