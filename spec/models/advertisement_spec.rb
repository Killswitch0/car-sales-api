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
require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
