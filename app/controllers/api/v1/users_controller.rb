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
        @user.save!

        render json: @user
      rescue ActiveRecord::RecordNotUnique
        render_could_not_create_error('User with same email exists.')
      rescue StandardError => e
        render_could_not_create_error("Unable to create user: #{e}")
      end

      def update
        @user = User.find(params[:id])
        @user.update(user_params)

        render json: @user, status: 200
      rescue ActiveRecord::RecordNotFound
        render_not_found_error('User not found!')
      rescue StandardError
        render_could_not_create_error('Unable to update user.')
      end

      def destroy
        @user = User.find(params[:id])
        if @user
          @user.destroy
          render json: { message: 'User successfully deleted.' }, status: 200
        else
          render_could_not_create_error('Unable to delete user.')
        end
      end

      def change_password
        @user = User.find(params[:user_id])

        if @user.authenticate(change_password_params[:current_password])
          @user.password = change_password_params[:new_password]
          @user.save!

          render json: { message: 'Password successfully updated.' }, status: 200
        else
          render_unauthorized('Wrong password entered')
        end
      rescue ActiveRecord::RecordNotFound
        render_not_found_error('User not found!')
      rescue StandardError => e
        render_could_not_create_error("Unable to update user: #{e}")
      end

      private

      def user_params
        params.require(:user).permit(:email, :first_name, :last_name, :password)
      end

      def change_password_params
        params.permit(:current_password, :new_password)
      end
    end
  end
end
