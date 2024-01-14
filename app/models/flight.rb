# == Schema Information
#
# Table name: flights
#
#  id                   :bigint           not null, primary key
#  departure_airport_id :bigint           not null
#  arrival_airport_id   :bigint           not null
#  departure_time       :datetime
#  arrival_time         :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: 'Airport'#, foreign_key: 'departure_airport_id'
  belongs_to :arrival_airport, class_name: 'Airport'#, foreign_key: 'arrival_airport_id'

  validates_presence_of :departure_airport
  validates_presence_of :arrival_airport
end
