class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new(flight_id: @flight.id)
    params[:no_of_passengers].to_i.times { @booking.passengers.build } if @booking.passengers.empty?
  end

  def create
    @booking = Booking.new(booking_params)
    @flight = Flight.find(params[:booking][:flight_id])
    # passengers_attributes = params[:booking][:passengers_attributes]
    # @booking.passengers.build(passengers_attributes.values)
    # @booking.booking_owner_id = @booking.passengers.first.id

    if @booking.save
      redirect_to booking_path(@booking), notice: "booking was successfully created"
    else
      Rails.logger.info(@booking.errors.full_messages.to_sentence)
      @flight = Flight.find(booking_params[:flight_id])
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
