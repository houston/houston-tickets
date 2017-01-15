require "houston/tickets/engine"
require "houston/tickets/configuration"

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
  #
  #    register_events {{
  #      "tickets:create" => params("tickets").desc("Tickets was created"),
  #      "tickets:update" => params("tickets").desc("Tickets was updated")
  #    }}


  # Add a link to Houston's global navigation
  #
  #    add_navigation_renderer :tickets do
  #      name "Tickets"
  #      icon "fa-thumbs-up"
  #      path { Houston::Tickets::Engine.routes.url_helpers.tickets_path }
  #      ability { |ability| ability.can? :read, Project }
  #    end


  # Add a link to feature that can be turned on for projects
  #
  #    add_project_feature :tickets do
  #      name "Tickets"
  #      icon "fa-thumbs-up"
  #      path { |project| Houston::Tickets::Engine.routes.url_helpers.project_tickets_path(project) }
  #      ability { |ability, project| ability.can? :read, project }
  #    end

end
