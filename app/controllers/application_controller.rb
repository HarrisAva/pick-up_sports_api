class ApplicationController < ActionController::API

    def authenticate_request
        # access the header, Authorization part, split it and get the last part which is token ('Bearer: xxxxxxxxxxx')
        header = request.headers['Authorization']
        header = header.split(' ').last if header

        # extract the decoded token  and make sure that we can verify the token by passing in app secret_key_base
        # grap the payload (the first part of the JWT.encode)

        begin
            decoded = JWT.decode(header, Rails.application.secret_key_base).first
            @current_user = User.find(decoded["user_id"])

            # grap the user from user_id
            # @ is to be accessible through the app actions

        rescue JWT::ExpiredSignature
            render json: {error: "Token has expired"}, status: :unauthorized
        rescue JWT::DecodeError
            render json: {error: "unauthorized"}, status: :unauthorized
        end

    end
end

