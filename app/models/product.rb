class Product < ApplicationRecord
  has_many :departments
  has_many :categories, through: :departments

  validates :title, presence: true
  validates :description, presence: true
end
