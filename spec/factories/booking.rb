# frozen_string_literal: true
FactoryBot.define do
  factory :booking do
    id { 1 }
    start_time { "13:00" }
    end_time { "14:00" }
    field_type_id { 1 }
    price_id { 1 }
  end
end
