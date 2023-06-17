class Post < ApplicationRecord


  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 0, maximum: 500 }

  def get_post_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    image.variant(resize: "#{width}x#{height}^", gravity: "center", crop: "#{width}x#{height}+0+0").processed
  end

  def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end

# ransack 検索許可カラム（属性）
  def self.ransackable_associations(auth_object = nil)
    ["body","title"]
  end
# ransack 検索許可カラム（アソシエーション）
  def self.ransackable_attributes(auth_object = nil)
    ["body","title"]
  end

end