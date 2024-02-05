class BookingsController < ApplicationController
  before_action :set_flight, only: [:create]

  def new
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new(flight_id: @flight.id)
    @number_of_passengers = params[:no_of_passengers].to_i
  end

  def create
    ActiveRecord::Base.transaction do
      @booking = Booking.new(booking_params.except(:passengers))
      @booking.flight = @flight
      if @booking.save
        passenger_errors = associate_passengers(params[:booking][:passengers])

        if passenger_errors.any?
          flash.now[:alert] = "Could not save passengers: #{passenger_errors.join(', ')}"
          raise ActiveRecord::Rollback, "Passengers could not be associated"
        end

        set_booking_owner
      else
        flash.now[:alert] = "Sorry, your booking could not be saved."
        raise ActiveRecord::Rollback, "Booking could not be saved"
      end
      passenger_signed_in? ? (redirect_to booking_path(@booking), notice: "Booking was successfully created.") : set_booking_owner_password
    rescue ActiveRecord::Rollback
      Rails.logger.info(@booking.errors.full_messages.to_sentence)
      flash.now[:alert] = "Sorry, your booking could not be saved."
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

  def associate_passengers(passengers_attributes)
    errors = []
    passengers_attributes.each do |passenger_attrs|
      passenger = Passenger.find_or_initialize_by(email: passenger_attrs[:email])

      if passenger.new_record?
        passenger.name = passenger_attrs[:name]
        unless passenger.save
          errors << passenger.errors.full_messages.to_sentence
        end
      end
      @booking.passengers << passenger unless @booking.passengers.include?(passenger)
    end
    return errors
  end

  def set_booking_owner
    @booking_owner = current_passenger || @booking.passengers.first
    @booking.update(booking_owner: @booking_owner)
  end

  def set_booking_owner_password
    raw, enc = Devise.token_generator.generate(Passenger, :reset_password_token)
    @booking_owner.reset_password_token = enc
    @booking_owner.reset_password_sent_at = Time.now.utc
    @booking_owner.save(validate: false)
    redirect_to edit_passenger_password_path(reset_password_token: raw), notice: 'Please set your password.'
  end

  def booking_params
    params.require(:booking).permit(:id, :flight_id, :no_of_passengers, passengers: [:id, :name, :email])
  end
end
