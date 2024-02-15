# == Schema Information
#
# Table name: airports
#
#  id         :bigint           not null, primary key
#  name       :string
#  code       :string
#  country_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country    :string
#  city       :string
#
FactoryBot.define do
  factory :airport_1, class: 'Airport' do
    name        { 'Heathrow' }
    code        { 'LHR' }
    country_id  { '001' }
    country     { 'United Kingdom' }
    city        { 'London' }
  end

  factory :airport_2, class: 'Airport' do
    name        { 'Charles de Gaulle' }
    code        { 'CDG' }
    country_id  { '002' }
    country     { 'France' }
    city        { 'Paris' }
  end
  
  factory :airport_3, class: 'Airport' do
    name        { 'John F. Kennedy International' }
    code        { 'JFK' }
    country_id  { '003' }
    country     { 'United States' }
    city        { 'New York' }
  end
end
