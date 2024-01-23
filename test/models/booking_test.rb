# == Schema Information
#
# Table name: bookings
#
#  id               :bigint           not null, primary key
#  no_of_passengers :integer
#  flight_id        :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
