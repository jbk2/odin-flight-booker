class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new(flight_id: @flight_id)
    params[:no_of_passengers].to_i.times { @booking.passengers.build }
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
    params.require(:booking).permit(:id, :flight_id, passengers_attributes: [:name, :email])
  end
end
