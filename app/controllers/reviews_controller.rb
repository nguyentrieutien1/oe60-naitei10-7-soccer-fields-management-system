class ReviewsController < ApplicationController
  @@rating = 5

  def update
    @@rating = params[:rating]
  end

  def create
    @review = current_user.reviews.new(user_id: current_user.id, field_type_id: params[:field_type_id], content: params[:content], rating: @@rating)
    respond_to do |format|
      if @review.save!
        format.html { redirect_to field_path, notice: t("review.review_success") }
        format.turbo_stream
      else

        format.html { redirect_to field_path, notice: t("review.review_fail") }
        format.turbo_stream
      end
    end
  end
end
