# frozen_string_literal: true
FactoryBot.define do
  factory :review do
    id { 1 }
    rating { 5 }
    content { "Nice the field" }
    user_id { 1 }
    field_type_id { 1 }
  end
end
