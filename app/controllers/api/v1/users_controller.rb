# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :find_user, except: %i[create]

      def show
        render json: @user, status: :ok
      end

      def update
        return if @user.update(user_params)

        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end

      def destroy
        @user.destroy
      end

      private

      def find_user
        @user = User.find_by_username!(params[:_username])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
      end

      def user_params
        params.permit(:name, :username, :email, :password, :password_confirmation)
      end
    end
  end
end
