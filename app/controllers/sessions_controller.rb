class SessionsController < ApplicationController
  def create
    # find the user by username
    user = User.find_by(username: params[:username])
    # if the user is exist, run authenticate through has_secure_password and Bcrypt
    if user&.authenticate(params[:password])
      token = jwt_encode(user_id: user.id) # send back a token with jwt_encode of user_id in payload, and secret key base to verify the signature
      render json: {token: token}, status: :ok
    else
      render json: {error: "unauthorized"}, status: :unauthorized
    end
  end

  private
  # want to see payload after decoding the token, e.g. user_id and expiration date/time
  def jwt_encode(payload, exp = 24.hours.from_now) 
    payload[:exp] = exp.to_i
    # encode the payload using specific secret_key_base value (very longvalue)
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end

# user& -> if the user is exist
# ** make sure that every specific request that needs a token is included with a token in the request test that needs them **
