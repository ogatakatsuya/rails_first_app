class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  # ユーザーのログインを確認する
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t('flash.danger.please_log_in')
    redirect_to login_url, status: :see_other
  end
end
