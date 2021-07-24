class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  validates :title, :description, :short_description, :level, :language, :price, presence: true
  has_rich_text :description

  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_many :lessons, dependent: :destroy

  LANGUAGES = %w[English Tagalog Russian].freeze
  LEVELS = %w[Beginner Intermediate Advanced].freeze

  def to_s
    title
  end
end
