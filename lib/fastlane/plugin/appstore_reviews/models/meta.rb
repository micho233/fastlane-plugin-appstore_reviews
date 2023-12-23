require_relative "paging.rb"

module Fastlane
    module AppstoreReviews
      class Meta
        attr_accessor :paging

        def initialize(json)
          @paging = Paging.new(json['paging'])
        end
      end
    end
  end