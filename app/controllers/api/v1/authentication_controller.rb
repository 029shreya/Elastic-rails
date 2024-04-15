# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.now + 24.hours.to_i
          render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'),
                         username: @user.username }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end

      def signup
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      private

      def login_params
        params.permit(:email, :password)
      end

      def user_params
        params.permit(:name, :username, :email, :password, :password_confirmation)
      end
    end
  end
end
