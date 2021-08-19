class Address < ApplicationRecord
  belongs_to :customer

  validates :address,     presence: true
  validates :name,        presence: true
  validates :postal_code, presence: true

end
