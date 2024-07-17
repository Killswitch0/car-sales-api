class Advertisement < ApplicationRecord
  enum state: %i[ pending rejected approved ]

  belongs_to :user

  has_one_attached :photo
end
