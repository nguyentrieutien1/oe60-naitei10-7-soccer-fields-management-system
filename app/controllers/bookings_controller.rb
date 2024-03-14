# frozen_string_literal: true
class BookingsController < ApplicationController
  before_action :logged_in_user, :load_bookings, only: %i(index destroy)
  before_action :check_booking_owner, :check_status_booking, only: :destroy

  def index; end

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
    return if @booking.pending?

    flash[:danger] = @booking.confirmed? ? t("booking.confirmed") : t("booking.canceled")
    redirect_to booking_path
  end

  def load_bookings
    @bookings = current_user.bookings.latest
  end

  def check_booking_owner
    is_booking_owner = current_user.bookings.find_by(id: params[:id])
    return if is_booking_owner

    flash[:danger] = t("booking.not_your")
    redirect_to booking_path
  end
end
