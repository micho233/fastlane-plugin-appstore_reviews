require_relative "customer_review.rb"
require_relative "links.rb"
require_relative "meta.rb"

module Fastlane
    module AppstoreReviews
      class Response
        attr_accessor :data, :links, :meta

        def initialize(json)
            @data = json['data'].map { |item| CustomerReview.new(item) }
            @links = Links.new(json['links'])
            @meta = Meta.new(json['meta'])
          end
      end
    end
  end