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
