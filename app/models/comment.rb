class Comment < ApplicationRecord
  belongs_to :post

  validates :user_name, presence: true
  validates :body, presence: true
end
