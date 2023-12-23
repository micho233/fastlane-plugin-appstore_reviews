require_relative "links.rb"
module Fastlane
    module AppstoreReviews
      class ReviewRelationships
        attr_accessor :links

        def initialize(json)
          response = json['response']
          @links = Links.new(response)
        end
      end
    end
end