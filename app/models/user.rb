class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true 
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  before_save { email.downcase! }
  before_save { first_name.strip! }
  before_save { last_name.strip! }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email)
    if user && user.authenticate(password) then user
    else nil
    end
  end

end