class User < ApplicationRecord
  
  validates :email, presence: true
  # validates :email, uniqueness: true
  # validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates_presence_of :password_digest
  # before_create :generate_api_key

  has_secure_password

  private

  # def generate_api_key
  #   self.api_key = SecureRandom.uuid
  # end
end