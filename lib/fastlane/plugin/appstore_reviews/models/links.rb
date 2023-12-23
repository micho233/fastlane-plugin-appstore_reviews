module Fastlane
    module AppstoreReviews
      class Links
        attr_accessor :self_link, :related, :next_link

        def initialize(json)
          @self_link = json['self']
          @related = json['related'] || nil
          @next_link = json['next'] || nil
        end
      end
    end
  end