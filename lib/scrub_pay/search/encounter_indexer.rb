module ScrubPay
  module Search
    module EncounterIndexer
      extend ActiveSupport::Concern

      included do
        include Elasticsearch::Model
        include Elasticsearch::Model::Callbacks

        mappings do
          indexes :first_name
          indexes :last_name
          indexes :phone_number
          indexes :site_id, index: :not_analyzed
        end
      end
    end
  end
end
