class SslController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :verify ]
  skip_after_action :verify_authorized, only: [ :verify ]

  def verify
    render text: ENV['VALIDATION_SIGNATURE']
  end

end
