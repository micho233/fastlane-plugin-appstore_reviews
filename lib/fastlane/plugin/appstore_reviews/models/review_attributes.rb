require 'date'

module Fastlane
    module AppstoreReviews
      class ReviewAttributes
        attr_accessor :rating, :title, :body, :reviewer_nickname, :created_date, :territory

        def initialize(json)
          @rating = json['rating']
          @title = json['title']
          @body = json['body']
          @reviewer_nickname = json['reviewerNickname']
          @created_date = DateTime.parse(json['createdDate'])
          @territory = json['territory']
        end
      end
    end
end