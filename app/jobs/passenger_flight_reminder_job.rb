class PassengerFlightReminderJob < ApplicationJob
  queue_as :default

  def perform(booking)
    booking.passengers.each do |passenger|
      PassengerMailer.with(booking: booking, passenger: passenger).flight_reminder.deliver_later
    end
  end
end
