module Api
  module V1
    class HabitsController < ApplicationController
      before_action :require_login

      def index
        @habits = Habit.all
        render json: @habits
      end

      def show
        render json: @habit
      end

      def create
        @habit = Habit.new(habit_params)
        if @habit.save
          render json: @habit
        else
          render_could_not_create_error('Unable to create habit.')
        end
      end

      def update
        if @habit
          @habit.update(habit_params)
          render json: { message: 'Habit successfully updated.' }, status: 200
        else
          render_could_not_create_error('Unable to update habit.')
        end
      end

      def destroy
        if @habit
          @habit.destroy
          render json: { message: 'Habit successfully deleted.' }, status: 200
        else
          render_could_not_create_error('Unable to delete habit.')
        end
      end

    private

      def habit_params
        params.require(:habit).permit(:habit, :user_id)
      end

      def find_habit
        @habit = Habit.find(params[:id])
      end
    end
  end
end
