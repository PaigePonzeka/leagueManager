class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :permission
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :email, presence:     true, 
                              format:         { with: VALID_EMAIL_REGEX },
                              uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
 
  #has_one :team
  has_many :team_players
  has_many :teams, :through => :team_players
  has_many :team_managers
  has_many :teams, :through => :team_managers
  has_many :divisions_reps
  has_many :divisions, :through => :division_reps

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
