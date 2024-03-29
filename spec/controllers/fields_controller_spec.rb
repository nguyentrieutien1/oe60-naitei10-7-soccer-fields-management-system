# frozen_string_literal: true
require "rails_helper"

RSpec.describe FieldsController, type: :controller do
  let(:field) { create(:field) }

  describe "GET show" do
    context "when the field exists" do
      before do
        allow(Field).to receive(:find_by).and_return(field)
      end

      it "assigns the requested field to @field" do
        get :show, params: { id: field.id }
        expect(assigns(:field)).to eq(field)
      end

      it "renders the show template" do
        get :show, params: { id: field.id }
        expect(response).to render_template(:show)
      end
    end

    context "when the field does not exist" do
      before do
        allow(Field).to receive(:find_by).and_return(nil)
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
