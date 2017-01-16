require "unfuddle"

Unfuddle.config(Houston::Tickets.config.ticket_tracker_configuration(:unfuddle).merge(
  logger: Rails.logger,
  include_closed_on: true ))

Action.ignored_exceptions << Unfuddle::ConnectionError
