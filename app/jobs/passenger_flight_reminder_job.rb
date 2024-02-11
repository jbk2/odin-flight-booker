class PassengerFlightReminderJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 3

  sidekiq_retries_exhausted do |job, ex|
    Sidekiq.logger.warn "Failed #{job['class']} with #{job['args']}: #{job['error_message']}"
  end

  def perform(booking_id)
    booking = Booking.find(booking_id)
    return Rails.logger.info "Booking ##{booking_id} not found" unless booking
    
    booking.passengers.each do |passenger|
      PassengerMailer.with(booking: booking, passenger: passenger).flight_reminder.deliver_later
    end
  end
end
