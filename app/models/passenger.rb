# == Schema Information
#
# Table name: passengers
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  email                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
class Passenger < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  
  validates :email, presence: true
  # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_and_belongs_to_many :bookings
  has_many :owned_bookings, class_name: 'Booking', foreign_key: 'booking_owner_id'

  def password_required?
    super && self.owned_bookings.exists?
  end

end
