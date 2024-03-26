class ChangeBookedDateTypeToString < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :booked_date, :string
  end
end
