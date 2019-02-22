require 'openssl'

class User < ApplicationRecord

  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions, dependent: :destroy
  attr_accessor :password

  validates :email, :name, :username, presence: true
  validates :email, :username, uniqueness: true
  # Валидация максимальной длины ника - 40 символов
  validates :username, length: { maximum: 40}
  # Валидация ника - на наличие только букв, цифр и символа '_'
  validates_format_of :username, :with => /\A[a-z0-9_]*\z/
  # Валидация e-mail`a - на верный ввод почты.
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  validates_format_of :headers_color, :with => /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/, allow_nil: true

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password
  # Колбэк на downcase ника, при регистрации
  before_validation :downcase

  private

  def downcase
    self.username = self.username.downcase
  end

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    if user.present? &&
        user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password,
                                                                             user.password_salt, ITERATIONS,
                                                                             DIGEST.length, DIGEST))
    user
    else
      nil
    end
  end
end
