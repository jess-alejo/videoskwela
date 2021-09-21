# frozen_string_literal: true

class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  belongs_to :user, counter_cache: true
  belongs_to :lesson, counter_cache: true

  validates :content, presence: true
end
