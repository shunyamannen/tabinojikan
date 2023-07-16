class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "User", foreign_key: "follower_id" # usersテーブルを経由してfollowerカラムを指定
  belongs_to :followed, class_name: "User", foreign_key: "followed_id" # usersテーブルを経由してfollowedカラムを指定

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
