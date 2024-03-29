# frozen_string_literal: true
require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  user = User.new(FactoryBot.attributes_for(:user))
  review = Review.new(FactoryBot.attributes_for(:review))
  let(:dom_id) { "comment_#{SecureRandom.uuid}" }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new comment" do
        post :create, params: { review_id: review.id, content: "Great post!", dom_id: }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq(I18n.t("comment.comment_success"))
      end
    end

    context "with invalid params" do
      it "does not create a new comment" do
        allow_any_instance_of(Comment).to receive(:save).and_return(false)
        post :create, params: { review_id: review.id, content: "", dom_id: }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq(I18n.t("comment.comment_fail"))
      end
    end
  end
end
