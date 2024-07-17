class Advertisement < ApplicationRecord
  enum state: %i[ pending rejected approved ]

  belongs_to :user

  has_one_attached :photo

  validates :brand, presence: true
  validates :model, presence: true
  validates :body_type, presence: true
  validates :mileage, presence: true
  validates :colour, presence: true
  validates :price, presence: true
  validates :fuel, presence: true
  validates :year, presence: true
  validates :engine_capacity, presence: true
  validates :phone_number, presence: true
  validates :name, presence: true
end
