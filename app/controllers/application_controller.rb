class ApplicationController < ActionController::Base
  protect_from_forgery

  def signed_in?
    session[:uid].present?
  end

  helper_method :signed_in?

  def signin_required
    redirect_to signin_path unless signed_in?
  end
end
