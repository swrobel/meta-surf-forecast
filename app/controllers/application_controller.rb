# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def unlock
    cookies[:unlock] = { value: Rails.application.credentials.unlock_secret, expires: 5.years.from_now }
    redirect_to :root
  end

private

  def check_unlocked
    return unless ENV.fetch('UNLOCK_KEY', nil) && cookies[:unlock] != Rails.application.credentials.unlock_secret!

    raise ActionController::RoutingError, 'Not Found'
  end
end
