class UserSerializer < ApplicationSerializer
  attributes :id

  has_many :bookings

  has_many :favorite_field_types
end
