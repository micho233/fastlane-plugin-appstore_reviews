module Fastlane
    module AppstoreReviews
      class Paging
        attr_accessor :total, :limit
      
        def initialize(json)
          @total = json['total']
          @limit = json['limit']
        end
      end
    end
  end