# frozen_string_literal: true

class CommentsController < ApplicationController
  layout "guest"

  before_action :logged_in_user, :assign_dom_each_comment, :load_review, only: :create
  after_action :load_review, only: :create

  def create
    @comment = current_user.comments.new comment_params
    @is_show_comment_quantity = false
    respond_to do |format|
      if @comment.save
        if @comment.parent_comment_id
          @is_show_comment_quantity = false
        else
          @review.comments << @comment
          @is_show_comment_quantity = true
        end
        format.html { redirect_to field_path, notice: t("comment.comment_success") }
      else
        format.html { redirect_to field_path, notice: t("comment.comment_fail") }
      end
      format.turbo_stream
    end
  end

  private

  def load_review
    @review = Review.find_by(id: params[:review_id])
  end
  def assign_dom_each_comment
    @dom_id = params[:dom_id]
  end

  def comment_params
    params.permit :review_id, :content, :parent_comment_id
  end
end
