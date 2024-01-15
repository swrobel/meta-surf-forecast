# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :locked?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def root
    redirect_to_default(locked?)
  end

  def unlock
    cookies[:unlock] = { value: Rails.application.credentials.unlock_secret, expires: 5.years.from_now }
    redirect_to_default(false)
  end

private

  def redirect_to_default(locked)
    redirect_to "/southern-california/#{locked ? 'buoys' : 'los-angeles'}"
  end

  def locked?
    ENV.fetch('UNLOCK_KEY', nil) && cookies[:unlock] != Rails.application.credentials.unlock_secret!
  end

  def check_unlocked
    return unless locked?

    raise ActionController::RoutingError, 'Not Found'
  end
end
