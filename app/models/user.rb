class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :likes
  has_many :posts

  def liked?(post)
    likes.liked.find_by(post: post).present?
  end

  def reposted?(post)
    posts.find_by(repost: post).present?
  end
end
