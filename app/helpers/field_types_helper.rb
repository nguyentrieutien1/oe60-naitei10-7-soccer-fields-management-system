# frozen_string_literal: true

module FieldTypesHelper
  def booking_hours
    hours = []
    current_hour = Time.now.hour + 1

    (24 - (current_hour)).times do |hour|
      hour_offset = current_hour + hour
      next if hour_offset < current_hour

      start_time = "#{hour_offset.to_s.rjust(2, "0")}:00"
      end_time = "#{(hour_offset + 1).to_s.rjust(2, "0")}:00"

      booked = @field_types_booked.any? { |booking| booking[:start_time] == start_time && !booking.canceled? }
      hours << { start_time: start_time, end_time: end_time, booked: booked }
    end

    hours
  end

  def field_type_status(field_type)
    field_type.is_availible ? :success : :danger
  end

  def field_type_label_button_status(field_type)
    field_type.is_availible ? t("button.availible_field") : t("button.inavailible_field")
  end
end
