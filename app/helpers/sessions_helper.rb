# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def successful_login(user)
    reset_session
    log_in(user)
    redirect_to user
  end

  def failed_login
    flash.now[:danger] = t('flash.danger.user_login')
    render 'new', status: :unprocessable_entity
  end

  def current_user
    return unless session[:user_id]

    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    reset_session
  end
end
