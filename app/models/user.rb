class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy

  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_follows, source: :following

  has_many :passive_follows, class_name: "Follow", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower


  validates :name, presence: true,
                   format: { with: /\A[a-zA-Z]+\z/, message: "Please enter a valid name which contains only alphabets" }


  validates :birth_date, presence: true,
                         comparison: { less_than: 16.years.ago.to_date, message: "You must be older than 16 years" }

  validates :mobile_number, presence: true,
                            format: { with: /\A[7-9]\d{9}\z/, message: "Please enter a valid mobile number starting with 7, 8, or 9 and exactly 10 digits" }


  validates :email, presence: true

  validates :password, presence: true,
                       format: {
                         with: /\A
                                 (?=.{8,})            # Minimum length 8
                                 (?=.*\d)             # At least one digit
                                 (?=.*[a-z])          # At least one lowercase
                                 (?=.*[A-Z])          # At least one uppercase
                                 (?=.*[[:^alnum:]])   # At least one special character
                               /x,
                         message: "Password must contain at least 8 characters, including 1 lowercase, 1 uppercase, 1 digit, and 1 special character"
                       }


  validates :gender, presence: true


  after_validation :log_errors

  private

  def log_errors
    if errors.any?
      Rails.logger.error("Validation failed: #{errors.full_messages.join(', ')}")
    end
  end
end
