module Houston
  module Tickets
    module Api
      module V1
        class TicketTasksController < Houston::Tickets::ApplicationController
          before_action :api_authenticate!
          before_action :find_project_and_ticket
          before_action :find_task, only: [:update, :destroy]
          skip_before_action :verify_authenticity_token

          attr_reader :project, :ticket, :task

          rescue_from ActiveRecord::RecordNotFound do
            head 404
          end

          def index
            authorize! :read, Task.new(project: project)
            render json: ticket.tasks.map { |task| present_task(task) }
          end

          def create
            task = ticket.tasks.build params.slice(:description, :effort).merge(project: project)
            authorize! :create, task

            task.updated_by = current_user
            if task.save
              render json: present_task(task), status: :created
            else
              render json: {errors: task.errors.full_messages}, status: :unprocessable_entity
            end
          end

          def update
            authorize! :update, task

            task.attributes = params.slice(:description, :effort)
            task.updated_by = current_user
            if task.save
              head :ok
            else
              render json: {errors: task.errors.full_messages}, status: :unprocessable_entity
            end
          end

          def destroy
            authorize! :destroy, task

            task.destroy
            head :ok
          end

        private

          def present_task(task)
            { id: task.id,
              number: task.number,
              letter: task.letter,
              description: task.description,
              effort: task.effort,
              committedAt: task.first_commit_at,
              completedAt: task.completed_at }
          end

          def find_project_and_ticket
            @project = Project.find_by_slug! params[:slug]
            @ticket = project.tickets.find_by_number! params[:number]
          end

          def find_task
            @task = ticket.tasks.find params[:id]
          end

        end
      end
    end
  end
end
