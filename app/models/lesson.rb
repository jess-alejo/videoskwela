class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :course

  validates :title, presence: true
  validates :content, presence: true
end
