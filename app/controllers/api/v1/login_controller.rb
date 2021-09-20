module Api
  module V1
    class LoginController < ApplicationController
      include RequestExceptionHandler

      def index
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          render json: { token: token(user.id), user_id: user.id }, status: :created
        else
          render json: { errors: ['Sorry, incorrect email or password'] }, status: :unprocessable_entity
        end
      end
    end
  end
end
