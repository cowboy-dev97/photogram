class Post < ApplicationRecord
validates :image, presence: true
  validates :user_id, presence: true

  belongs_to :user

  has_one_attached :image
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :comments
end
