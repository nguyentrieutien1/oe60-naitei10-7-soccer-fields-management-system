# frozen_string_literal: true
class ReportsController < ApplicationController
  def self.send_monthly_report
    admins = User.admin
    admins.each do |admin|
      total_amount = admin.fields.joins(field_types: { bookings: :price }).where(fields: { user_id: admin.id }, 
                                                                                 bookings: { status: [:confirmed] }).select("prices.price").sum("prices.price")
      BillingMailer.revenue_report(admin, total_amount).deliver_now
    end
  end
end
