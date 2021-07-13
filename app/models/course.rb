class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :description, :short_description, :level, :language, :price, presence: true
  has_rich_text :description

  belongs_to :author, class_name: 'User', foreign_key: :user_id

  LANGUAGES = %w[English Tagalog Russian].freeze
  LEVELS = %w[Beginner Intermediate Advanced].freeze

end
