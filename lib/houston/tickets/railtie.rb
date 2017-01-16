require "houston/tickets/commit_ext"
require "houston/tickets/project_ext"
require "houston/tickets/user_ext"

module Houston
  module Tickets
    class Railtie < ::Rails::Railtie

      # The block you pass to this method will run for every request
      # in development mode, but only once in production.
      config.to_prepare do
        ::Commit.send(:include, Houston::Tickets::CommitExt)
        ::Project.send(:include, Houston::Tickets::ProjectExt)
        ::User.send(:include, Houston::Tickets::UserExt)
      end

    end
  end
end
