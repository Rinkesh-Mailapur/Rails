class Category < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :cat_name, presence: true, length: { maximum: 40, message: "Maximum words allowed for category is 40 words" }
  after_validation :log_errors
  def log_errors
    if errors.any?
      Rails.logger.error("Validation failed: #{errors.full_messages.join(', ')}")
    end
  end
end
