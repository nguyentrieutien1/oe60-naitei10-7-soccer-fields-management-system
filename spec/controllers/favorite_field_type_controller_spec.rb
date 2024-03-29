# frozen_string_literal: true
require "rails_helper"

RSpec.describe FavoriteFieldTypesController, type: :controller do
  let(:user) { create(:user) }
  let(:field_type) { create(:field_type) }
  let(:dom_id) { "favorite_#{SecureRandom.uuid}" }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new favorite field type" do
        post :create, params: { field_type_id: field_type.id, dom_id: }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq(I18n.t("fields.favorite_success"))
      end
    end

    context "with invalid params" do
      it "does not create a new favorite field type" do
        allow_any_instance_of(FavoriteFieldType).to receive(:save).and_return(false)
        post :create, params: { field_type_id: field_type.id, dom_id: }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq(I18n.t("fields.favorite_fail"))
      end
    end
  end
end
