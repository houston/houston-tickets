module Houston
  module Tickets
    module ProjectExt
      extend ActiveSupport::Concern

      included do
        has_many :tickets, dependent: :destroy, extend: TicketSynchronizer
        has_many :milestones, dependent: :destroy, extend: MilestoneSynchronizer
        has_many :uncompleted_milestones, -> { uncompleted }, class_name: "Milestone"

        has_adapter :TicketTracker
      end



      module ClassMethods
        def with_syncable_ticket_tracker
          where [ "COALESCE(projects.props->'adapter.ticketTracker', 'None') NOT IN (?)", %w{None Houston} ]
        end
      end



      def ticket_tracker_project_url
        ticket_tracker.project_url
      end

      def ticket_tracker_ticket_url(ticket_number)
        ticket_tracker.ticket_url(ticket_number)
      end



      def create_ticket!(attributes)
        ticket = tickets.build attributes.merge(number: 0)
        ticket = tickets.create_from_remote ticket_tracker.create_ticket!(ticket) if ticket.valid?
        ticket
      end



      def find_or_create_tickets_by_number(*numbers)
        tickets.numbered(*numbers, sync: true)
      end

      def all_tickets
        tickets.fetch_all
      end

      def open_tickets
        tickets.fetch_open
      end

      def find_tickets(*query)
        tickets.fetch_with_query(*query)
      end



      def all_milestones
        milestones.fetch_all
      end

      def open_milestones
        milestones.fetch_open
      end

      def create_milestone!(attributes)
        milestone = milestones.build attributes
        if milestone.valid?
          if ticket_tracker.respond_to?(:create_milestone!)
            milestone = milestones.create(
              attributes.merge(
                ticket_tracker.create_milestone!(milestone).attributes))
          else
            milestone.save
          end
        end
        milestone
      end



      def ticket_tracker_sync_in_progress?
        ticket_tracker_sync_started_at.present? and ticket_tracker_sync_started_at > 5.minutes.ago
      end


    end
  end
end
