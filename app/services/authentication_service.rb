class AuthenticationService
  def initialize(user_details)
    @user_details = user_details
  end

  def create_user
    user = User.create!(@user_details)
    login(user)
  rescue ActiveRecord::RecordInvalid
    raise
  end

  def login(user = nil)
    user ||= User.find_by(email: @user_details[:email])
    if user && user.authenticate(@user_details[:password])
      return user.tokens.create(token: JsonWebToken.encode(user_id: user.id))
    else
      raise(ExceptionHandler::AccessDenied, Messages.user_not_logged_in)
    end
  end

  def logout
  end
end