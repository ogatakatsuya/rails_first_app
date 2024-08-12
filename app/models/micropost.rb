# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 140 }
  error_size = 'should be less than 5MB'
  error_ext = 'must be a valid image format'
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: error_ext },
                    size: { less_than: 5.megabytes,
                            message: error_size }
end
