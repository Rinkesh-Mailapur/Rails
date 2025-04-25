class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :category
  validates :title, presence: true, length: { maximum: 100, message: "Title must be under 100 characters" }
  validates :content, presence: true, length: { minimum: 50, message: "Minimum 50 characters are required to post the content " }
  after_validation :log_errors

  def log_errors
    if errors.any?
      Rails.logger.error("Validation failed: #{errors.full_messages.join(', ')}")
    end
  end
end
