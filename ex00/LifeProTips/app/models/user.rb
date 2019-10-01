class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }
  before_save { self.email = email.downcase }
  before_save { self.name = name.downcase }
end
