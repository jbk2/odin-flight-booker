require 'rails_helper'

RSpec.describe PassengerFlightReminderJob, type: :job do
  include ActiveJob::TestHelper
  include_context 'common setup'
  
  it 'enqueues a passenger flight reminder job' do
    expect {
      PassengerFlightReminderJob.perform_later(booking_1.id)
    }.to have_enqueued_job.with(booking_1.id)
  end

  it 'sends and email to each passenger' do
    perform_enqueued_jobs do
      PassengerFlightReminderJob.perform_later(booking_1.id)

      booking_1.passengers.each do |p|
        expect(ActionMailer::Base.deliveries.any? { |email| email.to.include?(p.email) }).to be_truthy
      end
    end
  end

end
