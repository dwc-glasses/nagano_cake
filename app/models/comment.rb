class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :body, presence: true
end
