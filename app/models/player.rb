class Player < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  attr_accessible :name, :email, :password, :password_confirmation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence:     true, 
                              format:         { with: VALID_EMAIL_REGEX },
                              uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
 
  has_one :team
  has_many :teams, :through => :team_players

  def Player.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Player.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = Player.encrypt(Player.new_remember_token)
    end
end
