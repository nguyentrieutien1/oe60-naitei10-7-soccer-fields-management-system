# frozen_string_literal: true
FactoryBot.define do
  factory :field do
    address { "Hoa Khanh - Da Nang" }
    description { "Beautiful the field" }
    phone_number { "0866037302" }
    user_id { 1 }
    name { "A" }
  end
end
