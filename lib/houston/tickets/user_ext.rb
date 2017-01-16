module Houston
  module Tickets
    module UserExt
      extend ActiveSupport::Concern

      included do
        has_many :tickets, foreign_key: "reporter_id"
      end

    end
  end
end
