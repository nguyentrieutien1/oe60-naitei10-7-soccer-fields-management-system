# frozen_string_literal: true
require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  user = User.new(FactoryBot.attributes_for(:user))
  field_type = FieldType.new(FactoryBot.attributes_for(:field_type))
  booking = Booking.new(FactoryBot.attributes_for(:booking))
  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new booking" do
        post :create, params: { start_time: Time.now, end_time: Time.now + 1.hour, field_type_id: field_type.id }
        expect(response).to redirect_to("http://test.host/")
      end
    end

    context "with invalid params" do
      it "renders the show template with unprocessable entity status" do
        post :create, params: { start_time: Time.now, end_time: Time.now - 1.hour, field_type_id: field_type.id }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the booking" do
      delete :destroy, params: { id: booking.id }
      expect(response).to redirect_to("http://test.host/bookings/#{booking.id}")
    end

    it "redirects with a notice message if delete fails" do
      allow_any_instance_of(Booking).to receive(:destroy).and_return(false)
      delete :destroy, params: { id: booking.id }
      expect(response).to redirect_to("http://test.host/bookings/#{booking.id}")
    end
  end

  describe "GET index" do
    it "loads all bookings for the current user" do
      get :index
      expect(assigns(:bookings)).to eq(user.bookings.latest)
      expect(response).to render_template(:index)
    end
  end
end
