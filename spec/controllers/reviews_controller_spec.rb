require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:field_type) { create(:field_type) }

  describe "POST create" do
    before do
      allow(controller).to receive(:current_user).and_return(user)
    end
    context "with valid params" do
      it "creates a new review" do
        post :create, params: { field_type_id: field_type.id, content: "Great field!", rating: 5 }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "does not create a new review" do
        allow_any_instance_of(Review).to receive(:save).and_return(false)
        post :create, params: { field_type_id: field_type.id, content: "Bad field!", rating: 2 }, session: { rating: 2 }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq(I18n.t("review.review_fail"))
      end
    end
  end
end
