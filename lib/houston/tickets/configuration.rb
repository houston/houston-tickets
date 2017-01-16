module Houston::Tickets
  class Configuration

    def initialize
      @ticket_types = {}
    end

    def ticket_tracker(adapter, &block)
      raise ArgumentError, "#{adapter.inspect} is not a TicketTracker: known TicketTracker adapters are: #{Houston::Adapters::TicketTracker.adapters.map { |name| ":#{name.downcase}" }.join(", ")}" unless Houston::Adapters::TicketTracker.adapter?(adapter)
      raise ArgumentError, "ticket_tracker should be invoked with a block" unless block_given?

      configuration = HashDsl.hash_from_block(block)

      @ticket_tracker_configuration ||= {}
      @ticket_tracker_configuration[adapter] = configuration
    end

    def ticket_tracker_configuration(adapter)
      raise ArgumentError, "#{adapter.inspect} is not a TicketTracker: known TicketTracker adapters are: #{Houston::Adapters::TicketTracker.adapters.map { |name| ":#{name.downcase}" }.join(", ")}" unless Houston::Adapters::TicketTracker.adapter?(adapter)

      @ticket_tracker_configuration ||= {}
      @ticket_tracker_configuration[adapter] || {}
    end

    def ticket_types(*args)
      if args.any?
        @ticket_types = args.first
        @ticket_types.default = "EFEFEF"
      end
      @ticket_types.keys
    end

    def ticket_colors
      @ticket_types
    end

    def parse_ticket_description(ticket=nil, &block)
      if block_given?
        @parse_ticket_description_proc = block
      elsif ticket
        @parse_ticket_description_proc.call(ticket) if @parse_ticket_description_proc
      end
    end

  end
end
