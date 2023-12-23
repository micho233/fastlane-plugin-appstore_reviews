require_relative "customer_review.rb"
require_relative "review_attributes.rb"
require_relative "review_relationships.rb"
require_relative "links.rb"
require_relative "meta.rb"

module Fastlane
    module AppstoreReviews
      class CustomerReview
        attr_accessor :type, :id, :attributes, :relationships, :links

        def initialize(json)
          @type = json['type']
          @id = json['id']
          @attributes = ReviewAttributes.new(json['attributes'])
          @relationships = ReviewRelationships.new(json['relationships'])
          @links = Links.new(json['links'])
        end
      end
    end
  end