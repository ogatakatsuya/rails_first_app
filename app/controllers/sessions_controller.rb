# frozen_string_literal: true

class SessionsController < ApplicationController
  include SessionsHelper

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      successful_login(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    else
      failed_login
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
