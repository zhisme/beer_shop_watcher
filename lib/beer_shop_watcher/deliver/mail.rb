require 'rest-client'

module BeerShopWatcher
  module Deliver
    class Mail
      def self.call(filename)
        data = {
          from: "Beer shop watcher <mailgun@#{Secrets['mailgun']['domain']}>",
          to: Secrets['recipients'].join(', '),
          text: 'See results in attachment.',
          subject: "Beer shop daily export #{Date.today}",
          attachment: [File.new(filename)]
        }

        RestClient.post "https://api:#{Secrets['mailgun']['api_key']}"\
          "@api.mailgun.net/v3/#{Secrets['mailgun']['domain']}/messages", data
      end
    end
  end
end
