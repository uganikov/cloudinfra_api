class User < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :name, presence: true
  validates :password_digest, presence: true
  validates :token, uniqueness: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
