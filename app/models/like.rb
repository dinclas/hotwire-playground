class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :liked, -> { where(liked: true) }
end