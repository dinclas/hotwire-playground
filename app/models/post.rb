class Post < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: 'Post', foreign_key: :posts_id, optional: true

  has_many :comments, class_name: 'Post', foreign_key: :posts_id
  has_many :likes

  validates :text, length: { minimum: 5}, allow_blank: false
end
