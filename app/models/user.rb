class User < ActiveRecord::Base
  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # temporarily store password in memory
  # attr_accessor :password
  # attr_accessor :password_confirmation
  # add ^^ attributes for us.
  has_secure_password
  validates :password, length: { minimum: 5 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
            uniqueness: true,
            format: VALID_EMAIL_REGEX

# omg
  def full_name
    "#{first_name} #{last_name}".titleize
  end


end


# http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
# Use bcrypt algorithm
# requires a password_digest attribute
# password must be present
# must be less than 72 characters
# confirmation of password/password_confirmation = ensure they match

# add has_secure_password
# works without confirmation if not provided
