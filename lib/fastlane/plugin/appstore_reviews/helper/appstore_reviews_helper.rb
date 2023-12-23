require 'fastlane_core/ui/ui'
require 'spaceship'
require 'net/http'
require 'uri'
require 'json'
require_relative "../models/response.rb"

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class AppstoreReviewsHelper
      def self.show_message
        UI.message("Hello from the appstore_reviews plugin helper!")
      end

      def self.generateToken(params)
        key = params[:key]
        return Spaceship::ConnectAPI::Token.create(**key)
      end

      def self.getReviews(params, url=nil, reviews = [])
        token = params[:token]
        app_id = params[:app_id]
        time_frame = params[:time_frame]

        reviews_url = url
        if url.nil?
          reviews_url = "https://api.appstoreconnect.apple.com/v1/apps/#{app_id}/customerReviews?sort=-createdDate&limit=200"
        end
        puts "I am here"
        response = self.makeAPIrequest(reviews_url, token)
        parsed_json = JSON.parse(response)
        parsed_response = AppstoreReviews::Response.new(parsed_json)

        last_review = parsed_response.data.last
        last_review_on_page_date = last_review.attributes.created_date
        reviews.concat(parsed_response.data)

        if self.should_call_more_pages(time_frame, last_review_on_page_date) && !parsed_response.links.next_link.nil?
          self.getReviews(params, parsed_response.links.next_link, reviews)
        end

        return reviews
      end

      def self.should_call_more_pages(time_frame, last_review_date) 
        case time_frame
        when 'Today'
          return last_review_date == Date.today
        when 'Week'
          return last_review_date >= Date.today - 7 && last_review_date <= Date.today
        when 'Month'
          return last_review_date >= Date.today - 30 && last_review_date <= Date.today
        when 'Year'
          return last_review_date >= Date.today - 365 && last_review_date <= Date.today
        else
          return true
        end
      end

      def self.makeAPIrequest(url, token)
        uri = URI(url)
        request = Net::HTTP::Get.new(uri)

        if token.expired?
          UI.message("App Store Connect API token expired at #{token.expiration}... refreshing")
          token.refresh!
        end

        request['Authorization'] = "Bearer #{token.text}"

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(request)
        end

        case response
        when Net::HTTPSuccess then
          return response.body
        else
          UI.user_error!("AppstoreConnect API Request finished with error code: #{response.code}")
        end
      end

      def self.getTimeFrame
          return ['Today', 'Week', 'Month', 'Year']
      end
    end
  end
end
