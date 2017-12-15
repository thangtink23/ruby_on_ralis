class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :content, presence: true
end
