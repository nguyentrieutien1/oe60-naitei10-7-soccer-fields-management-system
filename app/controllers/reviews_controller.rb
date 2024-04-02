# frozen_string_literal: true
class ReviewsController < ApplicationController
  before_action :logged_in_user, :booking_params, :load_field_type, only: %i(create update)

  def update
    session[:rating] = params[:rating]
  end

  def create
    @review = current_user.reviews.new(field_type_id: params[:field_type_id], content: params[:content], rating: session[:rating])
    respond_to do |format|
      if @review.save
        @field_type.reviews << @review
        session[:rating] = 5
        format.html { redirect_to field_path, notice: t("review.review_success") }
      else

        format.html { redirect_to field_path, notice: t("review.review_fail") }
      end
      format.turbo_stream
    end
  end

  private

  def booking_params
    params.permit :start_time, :end_time, :field_type_id, :price_id
  end

  def load_field_type
    @field_type = FieldType.find_by(id: params[:field_type_id])
    return if @field_type

    flash[:danger] = t("field_types.not_found")
    redirect_to root_path
  end
end
