class User < ApplicationRecord
  has_many :orders
  before_create :set_auth_token

  validates :email, :name, :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :email, uniqueness: true

  private
  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end

end
