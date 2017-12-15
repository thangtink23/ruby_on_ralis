class Hotel < ApplicationRecord
	has_many :reviews, dependent: :destroy
  validates :name, presence: true, length: {maximum: 20}
  validates :address, presence: true
  validates :description, presence: true
  validates :phone, presence: true
  validates :star, presence: true,
    numericality: {greater_than: 0, less_than_or_equal_to: 5}
  validates :max_price, presence: true
  validates :min_price, presence: true
end
