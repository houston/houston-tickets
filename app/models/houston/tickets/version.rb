module Houston
  module Tickets
    class Version < VestalVersions::Version
      self.table_name = "tickets_versions"
    end
  end
end
