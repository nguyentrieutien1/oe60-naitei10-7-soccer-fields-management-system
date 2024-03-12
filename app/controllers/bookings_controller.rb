# frozen_string_literal: true
class BookingsController < ApplicationController
  def booking_history
    @bookings = current_user.bookings.latest
  end
end
