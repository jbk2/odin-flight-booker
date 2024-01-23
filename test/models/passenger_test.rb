# == Schema Information
#
# Table name: passengers
#
#  id         :bigint           not null, primary key
#  name       :string
#  email      :string
#  booking_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class PassengerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
