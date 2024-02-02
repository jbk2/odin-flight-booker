# == Schema Information
#
# Table name: passengers
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  email                  :string
#  booking_id             :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
class Passenger < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :booking, optional: true

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :owned_bookings, class_name: 'Booking', foreign_key: 'booking_owner_id'
end
