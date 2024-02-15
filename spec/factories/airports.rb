FactoryBot.define do
  factory :airport_1, class: 'Airport' do
    name        { 'Parisian Airport' }
    code        { '0001' }
    country_id  { '01' }
    country     { 'France' }
    city        { 'Paris' }
  end

  factory :airport_2, class: 'Airport' do
    name        { 'Spanish Airport' }
    code        { '0002' }
    country_id  { '02' }
    country     { 'Spain' }
    city        { 'Madrid' }
  end
end
