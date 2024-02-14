class ApplicationController < ActionController::API

    def authenticate_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header

        # extract the token decoded and make sure that we can verify the token

        begin
            decoded = JWT.decode(header, Rails.application.secret_key_base).first
            @current_user = User.find(decoded["user_id"])

        rescue JWT::ExpiredSignature
            render json: {error: "Token has expired"}, status: :unauthorized
        rescue JWT::DecodeError
            render json: {error: "unauthorized"}, status: :unauthorized
        end

    end
end

