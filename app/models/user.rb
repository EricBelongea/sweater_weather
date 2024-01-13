class User
  validates :email, :api_key, presence: true
  validates :email, :api_key, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates_presence_of :password_digest

  has_secure_password
end