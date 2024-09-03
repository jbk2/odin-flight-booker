# == Schema Information
#
# Table name: passengers
#
#  id                     :bigint           not null, primary key
#  email                  :string
#  encrypted_password     :string           default("")
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_passengers_on_email                 (email) UNIQUE
#  index_passengers_on_reset_password_token  (reset_password_token) UNIQUE
#
class Passenger < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  
  validates :email, :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, length: { minimum: 2, maximum: 50 }
  # validate :must_have_at_least_one_booking, on: :update
  
  has_and_belongs_to_many :bookings
  has_many :owned_bookings, class_name: 'Booking', foreign_key: 'booking_owner_id'

  def password_required?
    super && self.owned_bookings.exists?
  end

  def update_password(params)
    update(params)
  end

  private
  def must_have_at_least_one_booking
    errors.add(:base, 'must have at least one booking') if self.bookings.blank?
  end
end
