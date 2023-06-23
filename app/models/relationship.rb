class Relationship < ApplicationRecord
  
   belongs_to :follower, class_name: "User" # usersテーブルを経由してfollowerカラムを指定
  belongs_to :followed, class_name: "User" # usersテーブルを経由してfollowedカラムを指定
end
