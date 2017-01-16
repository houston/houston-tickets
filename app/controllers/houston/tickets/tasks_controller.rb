module Houston
  module Tickets
    class TasksController < Houston::Tickets::ApplicationController
      before_action :find_task

      attr_reader :task

      def update
        authorize! :update, task

        project = task.project
        effort = params[:effort]
        effort = effort.to_d if effort
        effort = nil if effort && effort <= 0
        task.updated_by = current_user
        task.update_attributes effort: effort
        render json: [], status: :ok
      end

      def complete
        authorize! :update, task

        # !todo: authorize completing a task
        task.complete! unless task.completed?
        render json: Houston::Tickets::TaskPresenter.new(task)
      end

      def reopen
        authorize! :update, task

        # !todo: authorize completing a task
        task.reopen! unless task.open?
        render json: Houston::Tickets::TaskPresenter.new(task)
      end

    private

      def find_task
        @task = Task.find params[:id]
      end

    end
  end
end
