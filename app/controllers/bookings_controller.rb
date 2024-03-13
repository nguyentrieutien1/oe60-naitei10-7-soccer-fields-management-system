# frozen_string_literal: true
class BookingsController < ApplicationController
  before_action :check_status_booking, only: :destroy

  def booking_history
    @bookings = current_user.bookings.latest
  end

  def destroy
    respond_to do |format|
      if @booking.destroy
        format.html { redirect_to booking_history_path, notice: t("booking.delete_success") }
        format.js
      else
        format.html { redirect_to booking_history_path, notice: t("booking.delete_fail") }
        format.js
      end
    end
  end

  def check_status_booking
    @booking = Booking.find_by(id: params[:id])
    return unless @booking.status != 1

    flash[:danger] = t("booking.cannot_cancel")
    redirect_to booking_history_path
  end
end
