# frozen_string_literal: true
class BookingsController < ApplicationController
  before_action :logged_in_user, only: :index
  before_action :index, :check_status_booking, only: :destroy

  def index
    @bookings = current_user.bookings.latest
  end

  def destroy
    respond_to do |format|
      if @booking.destroy
        current_user.send_cancel_booking_success_email
        format.html { redirect_to bookings_path, notice: t("booking.delete_success") }
      else
        format.html { redirect_to bookings_path, notice: t("booking.delete_fail") }
      end
      format.turbo_stream
    end
  end

  private

  def check_status_booking
    @booking = Booking.find_by(id: params[:id])
    return if @booking.status == "pending"

    flash[:danger] =
      @booking.status == "confirmed" ? t("booking.confirmed") : t("booking.canceled")
    flash[:danger] = t("booking.cannot_cancel")
    redirect_to booking_path
  end
end
