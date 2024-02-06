class BookingsController < ApplicationController
  before_action :set_flight, only: [:create]

  def new
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new(flight_id: @flight.id)
    @number_of_passengers = params[:no_of_passengers].to_i
  end

  def create
    @booking = @flight.bookings.build(booking_params.except(:passengers))
    
    if @booking.save && associate_passengers(params[:booking][:passengers])
      set_booking_owner
      handle_post_booking_flow
    else
      handle_booking_failure
    end
  end

  def update_booking_owner_password
    @booking = Booking.find(params[:id])
    @booking_owner = @booking.booking_owner
    
    if @booking_owner.update_password(passenger_params)
      bypass_sign_in(@booking_owner)
      redirect_to booking_path(@booking), notice: 'Password was successfully updated.'
    else
      render_password_modal_with_errors
    end
  end
      
  def show
    @booking = Booking.find(params[:id])
  end

  def index
    @owned_bookings = current_passenger.owned_bookings
  end

  private
  def handle_post_booking_flow
    if passenger_signed_in?
      redirect_to booking_path(@booking), notice: "Booking was successfully created."
    else
      render_password_modal
    end
  end

  def handle_booking_failure
    flash.now[:alert] = @booking.errors.full_messages.to_sentence.presence || "Sorry, your booking could not be saved."
    render :new, status: :unprocessable_entity
  end

  def render_password_modal
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("passwordModal", partial: "password_form", locals: { booking: @booking }) }
      format.html { set_booking_owner_password }
    end
  end

  def render_password_modal_with_errors
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("passwordModal", partial: "password_form", locals: { booking: @booking, booking_owner: @booking_owner }) }
      format.html { render :set_booking_owner_password }
    end
  end
  
  def set_flight
    @flight = Flight.find(booking_params[:flight_id])
  end

  def associate_passengers(passengers_attributes)
    passengers_attributes.each do |passenger_attrs|
      passenger = Passenger.find_or_initialize_by(email: passenger_attrs[:email])

      if passenger.new_record?
        passenger.name = passenger_attrs[:name]
        unless passenger.save
          passenger.errors.full_messages.each do |message|
            @booking.errors.add(:base, "Passenger ID;#{passenger.id} Name;#{passenger.name}: #{message}")
          end
        end
      end
      @booking.passengers << passenger unless @booking.passengers.include?(passenger)
    end
    @booking.errors.empty?
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

  def passenger_params
    params.require(:passenger).permit(:password, :password_confirmation)
  end 
end
