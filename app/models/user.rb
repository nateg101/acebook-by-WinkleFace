require 'bcrypt'

class User < ApplicationRecord
  attr_accessor :password

  has_secure_password

  include BCrypt

  # def self.encrypt(password)
  #   BCrypt::Password.create(password)
  # end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { in: 6..20 }, :on => :create
end
