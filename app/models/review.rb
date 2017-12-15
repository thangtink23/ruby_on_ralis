class Review < ApplicationRecord
  belongs_to :user
  belongs_to :hotels

  validates :title, presence: true
  validates :content, presence: true
end
