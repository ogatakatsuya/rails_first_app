# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  include SessionsHelper
  def edit # rubocop:disable Metrics/AbcSize
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t('flash.success.account_activation')
      redirect_to user
    else
      flash[:danger] = t('flash.danger.invalid_activation')
      redirect_to root_url
    end
  end
end
