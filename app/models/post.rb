class Post < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: 'Post', foreign_key: :posts_id, optional: true
  belongs_to :repost, class_name: 'Post', foreign_key: :repost_id, optional: true

  has_many :comments, class_name: 'Post', foreign_key: :posts_id
  has_many :reposts, class_name: 'Post', foreign_key: :repost_id
  has_many :likes

  validates :text, presence: true, allow_blank: false, unless: :repost?

  protected

  def repost?
    repost.present?
  end
end
