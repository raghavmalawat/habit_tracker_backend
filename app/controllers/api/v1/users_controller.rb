# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include RequestExceptionHandler

      def index
        render json: User.all
      end

      def show
        @user = User.find(params[:id])
        render json: @user
      rescue ActiveRecord::RecordNotFound
        render_not_found_error('User not found!')
      end

      def create
        @user = User.new(user_params)
        @user.email.downcase!
        @user.save!

        render json: @user
      rescue ActiveRecord::RecordNotUnique
        render_could_not_create_error('User with same email exists.')
      rescue StandardError
        render_could_not_create_error('Unable to create user.')
      end

      def update
        @user = User.find(params[:id])
        if @user
          @user.update(user_params)
          render json: { message: 'User successfully updated.' }, status: 200
        else
          render_could_not_create_error('Unable to update habit.')
        end
      end

      def destroy
        @user = User.find(params[:id])
        if @user
          @user.destroy
          render json: { message: 'User successfully deleted.' }, status: 200
        else
          render_could_not_create_error('Unable to delete habit.')
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :first_name, :password)
      end

    end
  end
end
