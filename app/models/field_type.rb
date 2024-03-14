# frozen_string_literal: true

class FieldType < ApplicationRecord
  belongs_to :field

  has_many :bookings
  has_many :prices
  has_many :favorite_field_types
  has_many :reviews

  delegate :description, :address, :phone_number, to: :field, prefix: true
end
