# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end
notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
  defaults channel: "#general",
           username: "notifier"
end