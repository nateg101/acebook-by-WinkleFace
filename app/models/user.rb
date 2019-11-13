class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments
  acts_as_voter

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 6..20 }
end
