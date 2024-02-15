# == Schema Information
#
# Table name: bookings
#
#  id               :bigint           not null, primary key
#  flight_id        :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  booking_owner_id :bigint
#
FactoryBot.define do
  factory :booking_1, class: 'Booking' do
    association :flight, factory: :flight_1
    booking_owner { create(:passenger_1) }
    
    transient do
      passengers { [] }
    end
    
    after(:create) do |booking, evaluator|
      evaluator.passengers.each { |passenger| booking.passengers << passenger }
    end

  end

  factory :booking_2, class: 'Booking' do
    association :flight, factory: :flight_1
    booking_owner { create(:passenger_1) }
    
    transient do
      passengers { [] }
    end
    
    after(:create) do |booking, evaluator|
      evaluator.passengers.each { |passenger| booking.passengers << passenger }
    end

  end
end