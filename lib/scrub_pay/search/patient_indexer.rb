module ScrubPay
  module Search
    module PatientIndexer
      extend ActiveSupport::Concern

      included do
        include Elasticsearch::Model
        include Elasticsearch::Model::Callbacks

        mappings do
          indexes :user_first_name
          indexes :user_last_name
          indexes :user_email
          indexes :site_id, index: :not_analyzed
        end
      end

      def as_indexed_json(options = {})
          {
            id: self.id,
            user_first_name: self.user.first_name,
            user_last_name: self.user.last_name,
            user_email: self.user.email,
            site_id: self.site_id
          }
        end
    end
  end
end
