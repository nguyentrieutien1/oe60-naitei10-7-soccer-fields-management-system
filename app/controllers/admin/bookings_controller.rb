module Admin

  class BookingsController < ApplicationController
    def index
      @bookings = current_user.fields.joins(field_types: :bookings).select("*")

      @status_filter = session[:status_filter]
      if @status_filter.present?
        @bookings = @bookings.where("bookings.status = ?", @status_filter.to_i)
      end
      respond_to do |format|
        format.html
        format.xlsx {
          render "index", locals: { xlsx_author: "Nguyen Trieu Tien" }

        }
      end
    end
  end
end
