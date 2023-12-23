require 'fastlane/action'
require_relative '../helper/appstore_reviews_helper'
require 'spaceship'

module Fastlane
  module Actions
    class AppstoreReviewsAction < Action
      def self.run(params)
        key_id = params[:key_id]
        issuer_id = params[:issuer_id]
        key_content = params[:key_content]
        is_key_content_base64 = params[:is_key_content_base64]
        key_filepath = params[:key_filepath]
        duration = params[:duration]
        key = params[:key]
        app_id = params[:app_id]
        time_frame = params[:time_frame]

        if key_content.nil? && key.nil? && key_filepath.nil? && key.nil?
          UI.user_error!(":key_content or :key_filepath or :key is required")
        end

        if key
          token = Helper::AppstoreReviewsHelper.generateToken(key: key)
        elsif key_content
          key = other_action.app_store_connect_api_key(key_id: key_id,
                                                       issuer_id: issuer_id,
                                                       key_content: key_content,
                                                       is_key_content_base64: is_key_content_base64,
                                                       duration: duration,
                                                       in_house: false)
          token = Helper::AppstoreReviewsHelper.generateToken(key: key)
        elsif key_filepath
          key = other_action.app_store_connect_api_key(key_id: key_id,
                                                       issuer_id: issuer_id,
                                                       key_filepath: key_filepath,
                                                       duration: duration,
                                                       in_house: false)
          token = Helper::AppstoreReviewsHelper.generateToken(key: key)
        else
          UI.user_error!(":key_content or :key_filepath or :key is required")
        end

        return Helper::AppstoreReviewsHelper.getReviews(token: token, app_id: app_id, time_frame: time_frame)
      end

      def self.description
        "Plugin to retrieve customer reviews for the app"
      end

      def self.authors
        ["Mirsad Arslanovic"]
      end

      def self.return_value
        "Array of review objects"
      end

      def self.details
        # Optional:
        "Plugin to retrieve customer reviews for the app"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :key, 
                                       type: Hash,
                                       optional: true,
                                       conflicting_options: [:key_id, :issuer_id, :key_filepath, :key_content, :is_key_content_base64, :duration],
                                       description: "Spaceship::ConnectAPI.Token type"),
          FastlaneCore::ConfigItem.new(key: :key_id, 
                                       type: String,
                                       optional: true,
                                       conflicting_options: [:key],
                                       description: "The key ID"),
          FastlaneCore::ConfigItem.new(key: :issuer_id, 
                                       type: String,
                                       optional: true,
                                       conflicting_options: [:key],
                                       description: "The issuer ID "),
          FastlaneCore::ConfigItem.new(key: :key_filepath,
                                       type: String,
                                       optional: true,
                                       conflicting_options: [:key, :key_content],
                                       description: "The path to the key p8 file"),
          FastlaneCore::ConfigItem.new(key: :key_content,
                                       type: String,
                                       optional: true,
                                       conflicting_options: [:key, :key_filepath],
                                       description: "The content of the key p8 file"),
          FastlaneCore::ConfigItem.new(key: :is_key_content_base64,
                                       type: Boolean,
                                       optional: true,
                                       conflicting_options: [:key],
                                       description: "Whether :key_content is Base64 encoded or not false"),
          FastlaneCore::ConfigItem.new(key: :duration,
                                       optional: true,
                                       type: Integer,
                                       default_value: Spaceship::ConnectAPI::Token::DEFAULT_TOKEN_DURATION,
                                       conflicting_options: [:key],
                                       description: "The token session duration"),
          FastlaneCore::ConfigItem.new(key: :app_id,
                                       type: String,
                                       optional: false,
                                       description: "ID that uniquely identifies the app on appstore"),
          FastlaneCore::ConfigItem.new(key: :time_frame,
                                       description: "Time frame for the action (Today, Week, Month, Year)",
                                       optional: false,
                                       type: String,
                                       default_value: 'Today',
                                       verify_block: proc do |value|
                                         valid_values = ['Today', 'Week', 'Month', 'Year', 'All']
                                         unless valid_values.include?(value)
                                           UI.user_error!("Invalid value for time_frame: #{value}. Valid values are #{valid_values.join(', ')}")
                                         end
                                       end)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
