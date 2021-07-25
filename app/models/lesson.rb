class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  belongs_to :course

  validates :title, presence: true
  validates :content, presence: true

  def to_s
    title
  end
end
