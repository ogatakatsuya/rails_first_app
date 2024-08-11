# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    message = 'Account activation'
    mail to: user.email, subject: message
  end

  def password_reset
    @greeting = 'Hi'

    mail to: 'to@example.org'
  end
end
