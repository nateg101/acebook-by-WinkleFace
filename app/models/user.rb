require 'bcrypt'

class User < ApplicationRecord
  attr_accessor :password
  
  has_secure_password

  include BCrypt

  def self.encrypt(password)
    BCrypt::Password.create(password)
  end

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6, maxmium: 10 }, on: :create
end
