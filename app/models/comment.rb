class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  validates :message, presence: true, length: { maximum: 1000, message: "Maximum 1000 words are allowed in comment" }
  after_validation :log_errors

  def log_errors
    if errors.any?
      Rails.logger.error("Validation failed: #{errors.full_messages.join(', ')}")
    end
  end
end
