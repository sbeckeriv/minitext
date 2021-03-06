require 'twilio-ruby'

module Minitext
  class TwilioGateway
    attr_reader :client

    def initialize(config={})
      sid = config[:sid]
      token = config[:token]
      subaccount = config[:subaccount]
      @client = Twilio::REST::Client.new(sid, token)
      @client = client.accounts.find(subaccount) if subaccount
    end

    def deliver(message)
      client.sms.messages.create(
        from: message.from,
        to: message.to,
        body: message.body.strip,
      )
    end
  end
end