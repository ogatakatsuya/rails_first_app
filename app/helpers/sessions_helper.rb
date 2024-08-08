# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def successful_login(user)
    reset_session
    remember user
    log_in(user)
    redirect_to user
  end

  def failed_login
    flash.now[:danger] = t('flash.danger.user_login')
    render 'new', status: :unprocessable_entity
  end

  def current_user
    if (user_id = session[:user_id])
      find_user_by_id(user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        user
      end
    end
  end

  private

  def find_user_by_id(user_id)
    User.find_by(id: user_id)
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    reset_session
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
