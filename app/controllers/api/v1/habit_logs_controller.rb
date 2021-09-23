module Api
  module V1
    class HabitLogsController < ApplicationController
      before_action :require_login

      def index
        @habit_logs = HabitLog.where(users: current_user_id)
                              .select(:id, :habit_id, :achieved_frequency, :log_date)
                              .group_by(&:habit_id)


        render json: @habit_logs
      end

      def show
        @habit_log = find_habit_log
        render json: @habit_log[0]
      end

      def create
        @habit_log = HabitLog.new(habit_log_params)
        @habit_log.user_id = current_user_id
        if @habit_log.save
          render json: @habit_log
        else
          render_could_not_create_error('Unable to create habit log.')
        end
      end

      def update
        @habit_log = find_habit_log
        @habit_log.update(habit_log_params.slice(:achieved_frequency))

        render json: { data: @habit_log, message: 'Habit log successfully updated.' }, status: 200
      rescue ActiveRecord::RecordNotFound
        render_not_found_error('Habit log not found!')
      rescue StandardError
        render_could_not_create_error('Unable to update habit log.')
      end

      def destroy
        @habit_log = find_habit_log

        if @habit_log
          @habit_log.destroy
          render json: { message: 'Habit log successfully deleted.' }, status: 200
        else
          render_could_not_create_error('Unable to delete habit log.')
        end
      end

      private

      def habit_log_params
        params.require(:habit_log).permit(:habit_id, :achieved_frequency, :log_date)
      end

      def find_habit_log
        @habit = HabitLog.where(id: params[:id], user: current_user_id)
      rescue ActiveRecord::RecordNotFound
        render_not_found_error('Habit Log not found!')
      end
    end
  end
end
