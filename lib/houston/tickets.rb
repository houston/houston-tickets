require "houston/tickets/engine"
require "houston/tickets/configuration"
require "houston/adapters/ticket_tracker"
require "unfuddle"

module Houston
  module Tickets
    extend self

    def config(&block)
      @configuration ||= Tickets::Configuration.new
      @configuration.instance_eval(&block) if block_given?
      @configuration
    end

  end


  # Extension Points
  # ===========================================================================
  #
  # Read more about extending Houston at:
  # https://github.com/houston/houston-core/wiki/Modules


  # Register events that will be raised by this module

   register_events {{
     "task:committed" => params("task").desc("A commit mentioning this task was created"),
     "task:completed" => params("task").desc("A task was completed"),
     "task:reopened"  => params("task").desc("A task was reopened")
   }}


  # Add a link to feature that can be turned on for projects

  Houston.add_project_feature :ideas do
    name "Ideas"
    path { |project| Houston::Tickets::Engine.routes.url_helpers.project_open_ideas_path(project) }
    ability { |ability, project| ability.can?(:read, project.tickets.build) }
  end

  Houston.add_project_feature :bugs do
    name "Bugs"
    path { |project| Houston::Tickets::Engine.routes.url_helpers.project_open_bugs_path(project) }
    ability { |ability, project| ability.can?(:read, project.tickets.build) }
  end


  # Add buttons to the Project Header

  Houston.add_project_header_command :ticket_tracker_refresh do
    partial "houston/tickets/ticket_tracker_refresh"
    ability { |ability, project| project.ticket_tracker.supports_any?(:syncing_tickets, :syncing_milestones) }
  end

  Houston.add_project_header_command :new_ticket do
    partial "houston/tickets/new_ticket"
  end

end
