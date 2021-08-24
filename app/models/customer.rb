class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email,             presence: true
  validates :family_name,       presence: true
  validates :given_name,        presence: true
  validates :family_name_kana,  presence: true
  validates :given_name_kana,   presence: true
  validates :phone,             presence: true
  validates :postal_code,       presence: true
  validates :address,           presence: true


  has_many :cart_products, dependent: :destroy
  has_many :order_infos,   dependent: :destroy
  has_many :addresses,     dependent: :destroy
  has_many :comments,      dependent: :destroy


end
