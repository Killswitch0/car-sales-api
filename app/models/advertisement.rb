# == Schema Information
#
# Table name: advertisements
#
#  id              :bigint           not null, primary key
#  brand           :string
#  model           :string
#  body_type       :string
#  mileage         :integer
#  colour          :string
#  price           :integer
#  fuel            :string
#  year            :integer
#  engine_capacity :float
#  phone_number    :string
#  name            :string
#  user_id         :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  state           :integer          default("pending")
#  likes_count     :integer          default(0)
#
class Advertisement < ApplicationRecord
  enum state: %i[ pending rejected approved ]

  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  has_one_attached :photo

  scope :by_brand,     -> brand { where(brand: brand) }
  scope :by_model,     -> model { where(model: model) }
  scope :by_body_type, -> type { where(body_type: type) }
  scope :by_mileage,   -> mileage { where('mileage <= ?', mileage) }
  scope :by_colour,    -> colour { where(colour: colour) }
  scope :by_price,     -> start_price, end_price { where('price >= ? AND price <= ?', start_price, end_price) }
  scope :by_fuel,      -> fuel { where(fuel: fuel) }
  scope :by_year,      -> start_year, end_year { where('year >= ? AND year <= ?', start_year, end_year) }
  scope :by_engine_capacity, 
                       -> start_capacity, end_capacity { 
                         where('engine_capacity >= ? AND engine_capacity <= ?', start_capacity, end_capacity)
                       }
  
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
