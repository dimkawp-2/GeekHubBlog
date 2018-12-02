class User < ApplicationRecord
  has_many :posts
  validates :name, presence: true, length: { minimum: 4 }
  validates :password, presence: true, length: { in: 6..20 }
  validates :email, uniqueness: true
end
