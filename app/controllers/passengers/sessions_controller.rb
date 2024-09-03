# frozen_string_literal: true

class Passengers::SessionsController < Devise::SessionsController
  rate_limit to: 1, within: 3.minutes, only: :create,
    with: -> {
      reset_session
      redirect_to new_passenger_session_path, alert: "Login rate limit exceeded - Try again later."
  }

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
