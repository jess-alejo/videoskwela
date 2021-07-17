class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :courses

  after_create :assign_default_role

  def assign_default_role
    add_role(:student) if roles.blank?
  end

  def to_s
    email
  end
end
