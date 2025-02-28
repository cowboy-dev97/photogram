class Comment < ApplicationRecord
  validates :content, length: { in: 3..300 }

  belongs_to :user
  belongs_to :post
end
