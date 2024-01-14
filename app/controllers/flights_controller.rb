class FlightsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    # provides a view with a flight search and select for booking form
    @airports = Airport.order("#{sort_column}" + " " + "#{sort_direction}")
  end

  private
  def sort_column
    Airport.column_names.include?(params[:column]) ? params[:column].to_sym : :country
  end
  
  def sort_direction
    ['asc', 'desc'].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
