class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  has_rich_text :content
  belongs_to :course

  validates :title, presence: true
  validates :content, presence: true

  def to_s
    title
  end
end
