class Course < ApplicationRecord
  validates :title, presence: true
  has_rich_text :description

  belongs_to :author, class_name: 'User', foreign_key: :user_id
end
