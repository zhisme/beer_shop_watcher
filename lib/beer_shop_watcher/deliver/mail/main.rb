require 'beer_shop_watcher/deliver/mail/providers/mailgun'

module BeerShopWatcher
  module Deliver
    module Mail
      class Main
        class NoMailProvider < StandardError; end

        def self.call(mail_provider, **opts)
          case mail_provider
          when 'mailgun'
            Deliver::Mail::Providers::Mailgun.call(**opts)
          else
            raise NoMailProvider
          end
        end
      end
    end
  end
end
