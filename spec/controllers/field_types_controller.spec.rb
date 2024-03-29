# frozen_string_literal: true
require "rails_helper"

RSpec.describe FieldTypesController, type: :controller do
  let(:field_type) { create(:field_type) }

  describe "GET show" do
    context "when the field type exists" do
      before do
        allow(FieldType).to receive(:find_by).and_return(field_type)
        allow(Review).to receive(:reviews_newest_by)
        allow(field_type).to receive(:bookings)
      end

      it "assigns the requested field type to @field_type" do
        get :show, params: { id: field_type.id }
        expect(assigns(:field_type)).to eq(field_type)
      end

      it "loads reviews for the field type" do
        expect(Review).to receive(:reviews_newest_by).with(field_type.id)
        get :show, params: { id: field_type.id }
      end

      it "loads booked field types" do
        expect(field_type).to receive(:bookings)
        get :show, params: { id: field_type.id }
      end

      it "renders the show template" do
        get :show, params: { id: field_type.id }
        expect(response).to render_template(:show)
      end
    end

    context "when the field type does not exist" do
      before do
        allow(FieldType).to receive(:find_by).and_return(nil)
      end

      it "sets flash danger message" do
        get :show, params: { id: "non_existent_id" }
        expect(flash[:danger]).to eq(I18n.t("field_types.not_found"))
      end

      it "redirects to the root path" do
        get :show, params: { id: "non_existent_id" }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
