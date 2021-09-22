module Api
  module V1
    class HabitsController < ApplicationController
      before_action :require_login

      def index
        @habits = Habit.where(users: current_user_id)
        render json: @habits
      end

      def show
        @habit = find_habit
        render json: @habit[0]
      end

      def create
        @habit = Habit.new(habit_params)
        @habit.user_id = current_user_id
        if @habit.save
          render json: @habit
        else
          render_could_not_create_error('Unable to create habit.')
        end
      end

      def update
        @habit = find_habit
        @habit.update(habit_params.slice(:name, :description))

        render json: { data: @habit, message: 'Habit successfully updated.' }, status: 200
      rescue ActiveRecord::RecordNotFound
        render_not_found_error('Habit not found!')
      rescue StandardError
        render_could_not_create_error('Unable to update habit.')
      end

      def destroy
        @habit = find_habit

        if @habit
          @habit.destroy
          render json: { message: 'Habit successfully deleted.' }, status: 200
        else
          render_could_not_create_error('Unable to delete habit.')
        end
      end

      private

      def habit_params
        params.require(:habit)
              .permit(
                :name,
                :description,
                habit_frequency_attributes: %i[monday tuesday wednesday thursday friday saturday sunday]
              )
      end

      def find_habit
        @habit = Habit.where(id: params[:id], user: current_user_id)
      rescue ActiveRecord::RecordNotFound
        render_not_found_error('Habit not found!')
      end
    end
  end
end
