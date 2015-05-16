# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  session_token   :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :name, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6 }
  after_initialize :ensure_session_token

  has_many :subs, foreign_key: :moderator_id
  has_many :posts, foreign_key: :author_id

  attr_reader :password

  def self.find_by_credentials(name, password)
    @user = User.find_by(name: name)
    return @user if @user && @user.is_password?(password)
    nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
    self.save
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

end
