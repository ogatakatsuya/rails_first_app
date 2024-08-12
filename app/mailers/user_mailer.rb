# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    message = 'Account activation'
    mail to: user.email, subject: message
  end

  def password_reset(user)
    @user = user
    message = 'Password reset'
    mail to: user.email, subject: message
  end
end
