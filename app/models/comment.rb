class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_many :replies, dependent: :destroy

  validates :content, presence: true
end
