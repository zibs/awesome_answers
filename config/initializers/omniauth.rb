Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_SECRET_KEY"]
end
# omni auth comes in witha  biultin controller which will authenteicate and redirect
