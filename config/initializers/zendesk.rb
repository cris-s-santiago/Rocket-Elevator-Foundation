require 'zendesk_api'

@client = ZendeskAPI::Client.new do |config|
# #   # Mandatory:

  config.url = ENV['ZENDESK_URL'] # e.g. https://mydesk.zendesk.com/api/v2

# #   # Basic / Token Authentication
  config.username = ENV['ZENDESK_USERNAME']


# #   # Choose one of the following depending on your authentication choice
  config.token = ENV['ZENDESK_TOKEN']
  config.password = ENV['ZENDESK_PASSWORD']

end
