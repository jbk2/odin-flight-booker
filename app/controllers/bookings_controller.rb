class BookingsController < ApplicationController
  before_action :set_flight, only: [:create]

  def new
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new(flight_id: @flight.id)
    number_of_passengers = params[:no_of_passengers].to_i
    number_of_passengers.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.flight = @flight
    update_passenger_count

    Rails.logger.debug "&&&&&  Booking params: #{booking_params.inspect}"
    Rails.logger.debug "#####  Built Passengers before save: #{@booking.passengers.inspect}"    
    if @booking.save
      return if set_booking_owner
      redirect_to booking_path(@booking), notice: "Booking was successfully created."
    else
      Rails.logger.info(@booking.errors.full_messages.to_sentence)
      flash.now[:alert] = "Sorry, your booking could not be saved."
      passenger_count.times { @booking.passengers.build } unless @booking.passengers.any?
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private
  def set_flight
    @flight = Flight.find(booking_params[:flight_id])
  end

  def passenger_count
    (params[:no_of_passengers] || params[:booking][:passenger_count]).to_i
  end

  def update_passenger_count
    puts "********* Updating passenger count"
    Rails.logger.debug "££££ Passenger count: #{passenger_count}"
    Rails.logger.debug "#### Booking object: #{@booking}"
    desired_count = passenger_count
    current_count = @booking.passengers.reject(&:marked_for_destruction?).count
    difference = desired_count - current_count
  
    if difference.positive?
      puts "********* building passengers by #{difference}"
      difference.times { @booking.passengers.build }
    elsif difference.negative?
      puts "********* rejecting passengers by #{difference}"
      @booking.passengers.reject(&:marked_for_destruction?).last(difference.abs).each(&:mark_for_destruction)
    end
  end

  # extract out to two methods
  def set_booking_owner
    @booking_owner = current_passenger || @booking.passengers.first
    @booking.update(booking_owner: @booking_owner)
    unless current_passenger
      raw, enc = Devise.token_generator.generate(Passenger, :reset_password_token)
      @booking_owner.reset_password_token = enc
      @booking_owner.reset_password_sent_at = Time.now.utc
      @booking_owner.save(validate: false)
      redirect_to edit_passenger_password_path(reset_password_token: raw), notice: 'Please set your password.'
      return true
    end
    false
  end

  def booking_params
    params.require(:booking).permit(:id, :flight_id, :passenger_count, passengers_attributes: [:name, :email])
  end
end
