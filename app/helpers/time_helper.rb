# frozen_string_literal: true

module TimeHelper
  # match time in filed to show the price
  def map_with_time_of_day(array)
    current_hour = Time.now.hour
    period = if current_hour >= 5 && current_hour < 12
               "Morning"
             elsif current_hour >= 12 && current_hour < 18
               "Afternoon"
             else
               "Evening"
             end

    array.find { |obj| obj[:name] == period }
  end

  def past_date?(datetime_string, start_time, end_time)
    datetime = Time.parse(datetime_string).to_date
    start_hour = Time.parse(start_time).hour
    end_hour = Time.parse(end_time).hour
    current_hour = Time.now.hour
    !datetime.past? && start_hour > current_hour && end_hour > current_hour && start_time < end_time
  end
end
