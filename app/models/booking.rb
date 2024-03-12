# frozen_string_literal: true

class Booking < ApplicationRecord
  attribute :status, :integer, default: 1
  attribute :booked_date, :date, default: -> { Date.current }

  belongs_to :user
  belongs_to :field_type

  scope :latest, -> { order(created_at: :desc) }
end
