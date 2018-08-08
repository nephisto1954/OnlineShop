class Category < ApplicationRecord
  has_many :departments
  has_many :products, through: :departments

  validates :name, presence: true
end
