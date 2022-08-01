class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :name }
  has_many :posts, dependent: :destroy
end
