# frozen_string_literal: true
module BookingsHelper
  def check_status_booking(booking)
    if booking.pending?
      :primary
    else
      booking.confirmed? ? :success : :danger
    end
  end


  def format_booking_created_at(booking)
    "#{booking.created_at.to_time.strftime("%d/%m/%Y")} #{booking.created_at.to_time.strftime("%H:%M")}"
  end

  def format_booking_booked_date(booking)
    "#{booking.booked_date.to_time.strftime("%d/%m/%Y")} #{booking.booked_date.to_time.strftime("%H:%M")}"
  end

  def render_booking_status(booking)
    content_tag(:td) do
      if booking.pending?
        concat(content_tag(:button, t("button.cancel"), class: "btn btn-primary", type: "button", data: { toggle: "modal", target: "#{"#modal-"+"#{booking.id}"}" }))
      elsif booking.confirmed?
        concat(content_tag(:span,  t("button.confirm"), class: "badge badge-success"))
      else
        concat(content_tag(:span, t("button.rejected"), class: "badge badge-danger"))
      end
    end
  end
end
