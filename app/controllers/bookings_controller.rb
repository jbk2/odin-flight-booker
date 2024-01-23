class BookingsController < ApplicationController
  def new
    @no_of_passengers = params[:no_of_passengers].to_i
    @flight_id = params[:flight_id]
    @flight = Flight.find(@flight_id)
    @booking = Booking.new(flight_id: @flight_id, no_of_passengers: @no_of_passengers)
    @no_of_passengers.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      redirect_to booking_path(@booking), notice: "booking was successfully created"
    else
      render :new, status: :unprocessable_entity, notice: "Sorry your booking could not be saved"
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:id, :no_of_passengers, :flight_id, passengers_attributes: [:name, :email])
  end
end
