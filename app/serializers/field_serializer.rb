class FieldSerializer < ApplicationSerializer
  attributes :id

  belongs_to :user
end
