require "houston/tickets/engine"
require "houston/tickets/configuration"
require "houston/adapters/ticket_tracker"
require "houston/credentials"
require "unfuddle"
require "vestal_versions"


module Houston
  module Tickets
    extend self

    def dependencies
      [ :commits, :credentials ]
    end

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


  #

  Houston.accept_credentials_for "Unfuddle" do |login, password, errors|
    begin
      Unfuddle.with_config(username: login, password: password) { Unfuddle.instance.get("people/current") }
    rescue Unfuddle::UnauthorizedError
      errors.add(:base, "Invalid credentials")
    end
  end

  Houston.accept_credentials_for "Github" do |login, password, errors|
    begin
      Octokit::Client.new(login: login, password: password).user
    rescue Octokit::Forbidden
      errors.add(:base, "Account locked")
    rescue Octokit::Unauthorized
      errors.add(:base, "Invalid credentials")
    end
  end

end
