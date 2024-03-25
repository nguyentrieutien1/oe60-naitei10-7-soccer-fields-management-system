# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :field_type
  has_many :comments, dependent: :destroy

  scope :reviews_newest_by, ->(field_type_ids) { where(field_type_id: field_type_ids)}
end
