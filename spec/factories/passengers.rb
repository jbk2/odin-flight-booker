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
FactoryBot.define do
  factory :passenger_1, class: 'Passenger' do
    name      { 'jim' }
    sequence(:email) { |n| "jim#{n}@test.com" }
    password  { 'Password12!' }
  end
  
  factory :passenger_2, class: 'Passenger' do
    name      { 'jack' }
    sequence(:email) { |n| "jack#{n}@test.com" }
    password  { 'Password12!' }
  end
end
