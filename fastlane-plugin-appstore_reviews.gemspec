lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/appstore_reviews/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-appstore_reviews'
  spec.version       = Fastlane::AppstoreReviews::VERSION
  spec.author        = 'Mirsad Arslanovic'
  spec.email         = 'mirsad.arslanovic@gmail.com'

  spec.summary       = 'Plugin to retrieve customer reviews for the app'
  # spec.homepage      = "https://github.com/<GITHUB_USERNAME>/fastlane-plugin-appstore_reviews"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.required_ruby_version = '>= 2.6'

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  # spec.add_dependency 'your-dependency', '~> 1.0.0'

  spec.add_development_dependency('bundler')
  spec.add_development_dependency('fastlane', '>= 2.216.0')
  spec.add_development_dependency('pry')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rspec_junit_formatter')
  spec.add_development_dependency('rubocop', '1.50.2')
  spec.add_development_dependency('rubocop-performance')
  spec.add_development_dependency('rubocop-require_tools')
  spec.add_development_dependency('simplecov')
end
