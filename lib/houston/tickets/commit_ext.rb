module Houston
  module Tickets
    module CommitExt
      extend ActiveSupport::Concern

      included do
        has_and_belongs_to_many :tickets
        has_and_belongs_to_many :tasks

        after_create :associate_tickets_with_self
        after_create :associate_tasks_with_self

        prepend Overrides
      end



      module Overrides

        def ticket_numbers
          parsed_message[:tickets].map { |number, _| number }
        end

      protected

        def parse_message(clean_message)
          tickets = []
          clean_message.gsub!(TICKET_PATTERN) { tickets << [$1.to_i, $2]; "" }
          super.merge(tickets: tickets)
        end

      end



      def ticket_tasks
        @ticket_tasks ||= parsed_message[:tickets].each_with_object({}) do |(number, task), tasks_by_ticket|
          (tasks_by_ticket[number] ||= []).push(task) unless task.blank?
        end
      end

      def associate_tickets_with_self
        self.tickets = identify_tickets
      end

      def associate_tasks_with_self
        self.tasks = identify_tasks

        tasks.each do |task|
          task.mark_committed!(self)
        end
      end



      TICKET_PATTERN = /\[#(\d+)([a-z]*)\]/.freeze

    private

      def identify_tickets
        project.find_or_create_tickets_by_number(ticket_numbers)
      end

      def identify_tasks
        tickets.each_with_object([]) do |ticket, tasks|

          # Allow committers who are not using the Tasks feature
          # to mention a ticket (e.g. [#45]) and record progress
          # against its only (default) task.
          #
          # Note: this behavior is complected with time. Tasks
          # added _after_ this commit would alter the behavior
          # of this method if it were run later, retroactively.
          #
          letters = ticket_tasks.fetch(ticket.number) do
            ticket.tasks.count == 1 ? [ticket.tasks.first.letter] : []
          end

          tasks.concat ticket.tasks.lettered(*letters)
        end
      end

    end
  end
end
