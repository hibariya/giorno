class SessionsController < ApplicationController
  def new
    redirect_to '/auth/open_id'
  end

  def create
    auth = request.env["omniauth.auth"].symbolize_keys

    if auth[:uid] == Settings.open_id.uid
      session[:uid] = auth[:uid]

      redirect_to admin_entries_path
    end
  end

  def destroy
    reset_session

    redirect_to root_path
  end

  def failure
  end
end
