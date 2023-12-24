# appstore_reviews plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-appstore_reviews)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-appstore_reviews`, add it to your project by running:

```bash
fastlane add_plugin appstore_reviews
```

## About appstore_reviews

The appstore_reviews plugin allows you to conveniently retrieve customer reviews for your iOS app from the App Store. This plugin utilizes the App Center API key and app ID to fetch reviews, providing an easy and automated way to monitor and respond to user feedback.

## Usage

To use the appstore_reviews plugin, add one of the following code snippets to your Fastfile, depending on your preferred configuration method:

### Example 1: Using base64 key content

```bash
reviews = appstore_reviews(
    key_id: ENV["ASCAPI_KEY_ID"],
    issuer_id: ENV["ASCAPI_ISSUER_ID"],
    key_content: ENV["ASCAPI_KEY_CONTENT"],
    is_key_content_base64: true,
    duration: 1200,
    app_id: ENV["APP_ID"],
    time_frame: "All"
)
```

### Example 2: Using Key File Path

Use a file path to your API key for authentication.

```bash
reviews = appstore_reviews(
    key_id: ENV["ASCAPI_KEY_ID"],
    issuer_id: ENV["ASCAPI_ISSUER_ID"],
    key_filepath: "path/to/key.p8",
    duration: 1200,
    app_id: ENV["APP_ID"],
    time_frame: "All"
)
```

### Example 3: Using Spaceship Token

Leverage a Spaceship token for authentication. (refer: https://github.com/fastlane/fastlane/blob/master/spaceship/lib/spaceship/connect_api/token.rb)
```bash
reviews = appstore_reviews(
    key: token,
    duration: 1200,
    app_id: ENV["APP_ID"],
    time_frame: "All"
)
```

Also, check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
