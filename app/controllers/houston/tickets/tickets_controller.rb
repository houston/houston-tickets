module Houston
  module Tickets
    class TicketsController < Houston::Tickets::ApplicationController
      before_action :find_ticket, only: [:show, :update, :close, :reopen]

      attr_reader :ticket

      def show
        render json: Houston::Tickets::FullTicketPresenter.new(current_ability, ticket)
      end

      def update
        attributes = params.pick(:priority, :summary, :description)

        if ticket.update_attributes(attributes)
          render json: []
        else
          render json: ticket.errors, status: :unprocessable_entity
        end
      end

      def close
        authorize! :close, ticket
        ticket.close!
        render json: []
      rescue
        render json: [$!.message], status: :unprocessable_entity
      end

      def reopen
        authorize! :close, ticket
        ticket.reopen!
        render json: []
      rescue
        render json: [$!.message], status: :unprocessable_entity
      end

    private

      def find_ticket
        @ticket = Ticket.find(params[:id])
        @ticket.updated_by = current_user
      end

    end
  end
end
