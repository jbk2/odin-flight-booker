require 'pry-byebug'

class FlightsController < ApplicationController

  helper_method :search_submitted?

  def index
    @countries = Airport.distinct.order(:country).pluck(:country)
    @departure_airports = Airport.order(:city)
    @arrival_airports = Airport.order(:city)
    @flight_search_results = nil

    @show_welcome_modal = session[:seen_welcome_modal].nil?
    session[:seen_welcome_modal] = true

    # If #index called with params from flight search form, go and find params matching flights
    if search_submitted?
      @flight_search_results = Flight.where(
        departure_airport_id: params[:departure_airport_id],
        arrival_airport_id: params[:arrival_airport_id])
        .where("DATE(departure_time) BETWEEN ? AND ?", params[:departure_date].to_date - 5, params[:departure_date].to_date + 5).order(:departure_time)
    end
  end

  def update_departure_airports
    @departure_airports = Airport.where(country: params[:departure_country]).order(:city)
    respond_to do |format|
      format.turbo_stream { render 'update_departure_airports'}
    end
  end
  
  def update_arrival_airports
    @arrival_airports = Airport.where(country: params[:arrival_country]).order(:city)
    respond_to do |format|
      format.turbo_stream { render 'update_arrival_airports'}
    end
  end

  def update_departure_dates
    @departure_dates = Flight.where(departure_airport_id: params[:departure_airport_id],
      arrival_airport_id: params[:arrival_airport_id]).map { |f| f.departure_time.strftime('%Y-%m-%d') }
    respond_to do |format|
      format.turbo_stream { render 'update_departure_dates' }
    end
  end

  def search_submitted?
    params[:departure_airport_id] && params[:arrival_airport_id] && params[:departure_date]
  end
  
  def flight_params
    params.require(:flight).permit(:departure_country, :departure_airport_id, :arrival_country, :arrival_airport_id, :departure_date, :no_of_passengers)
  end
  
end