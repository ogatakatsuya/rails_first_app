# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'katsuya151225@icloud.com'
  layout 'mailer'
end
