class Course < ApplicationRecord
  validates :title, presence: true
  has_rich_text :description
end
