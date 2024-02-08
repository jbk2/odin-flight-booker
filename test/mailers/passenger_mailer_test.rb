require "test_helper"

class PassengerMailerTest < ActionMailer::TestCase
  test "welcome_booking_owner" do
    mail = PassengerMailer.welcome_booking_owner
    assert_equal "Welcome booking owner", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
