# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  validates :follower_id, presence: true # rubocop:disable Rails/RedundantPresenceValidationOnBelongsTo
  validates :followed_id, presence: true # rubocop:disable Rails/RedundantPresenceValidationOnBelongsTo
end
