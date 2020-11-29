require 'rest-client'

module BeerShopWatcher
  module Deliver
    module Mail
      module Providers
        class Mailgun
          def self.call(attachments:)
            data = {
              from: "Beer shop watcher <mailgun@#{Secrets['mailgun']['domain']}>",
              to: Secrets['recipients'].join(', '),
              text: 'See results in attachment.',
              subject: "Beer shop daily export #{Date.today}",
              attachment: attachments
            }

            RestClient.post "https://api:#{Secrets['mailgun']['api_key']}"\
              "@api.mailgun.net/v3/#{Secrets['mailgun']['domain']}/messages", data
          end
        end
      end
    end
  end
end
