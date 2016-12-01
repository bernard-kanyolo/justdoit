class AuthenticationController < ApplicationController
  def login
    data = {
      message: Messages.user_logged_in,
      auth_token: authentication_service.login.token
    }
    render_json(data)
  end

  private

  def authentication_service
    AuthenticationService.new(params)
  end
end