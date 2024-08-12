# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  include SessionsHelper
  before_action :get_user,   only: %i[edit update]
  before_action :valid_user, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]
  def new; end

  def edit; end

  def create # rubocop:disable Metrics/AbcSize
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t('flash.info.password_reset_email')
      redirect_to root_url
    else
      flash.now[:danger] = t('flash.danger.email_not_found')
      render 'new', status: :unprocessable_entity
    end
  end

  def update # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit', status: :unprocessable_entity
    elsif @user.update(user_params)
      @user.forget
      reset_session
      log_in @user
      @user.update(reset_digest: nil)
      flash[:success] = t('flash.success.password_reset')
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user # rubocop:disable Naming/AccessorMethodName
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    return if @user&.activated? && @user&.authenticated?(:reset, params[:id])

    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t('flash.danger.password_reset_expired')
    redirect_to new_password_reset_url
  end
end
