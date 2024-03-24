# frozen_string_literal: true

class FieldType < ApplicationRecord
  belongs_to :field

  has_one_attached :image
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :prices, dependent: :destroy
  has_many :favorite_field_types, dependent: :destroy

  attribute :is_availible, :boolean, default: true

  delegate :description, :address, :phone_number, to: :field, prefix: true
end
