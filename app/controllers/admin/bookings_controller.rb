
module Admin
  class BookingsController <  Admin::AdminController
    def index
      @bookings = Booking.all
      respond_to do |format|
        format.html
        format.xlsx {
          render "index", locals: {xlsx_author: "Elmer Fudd"}

        }
      end
    end
  end
end
