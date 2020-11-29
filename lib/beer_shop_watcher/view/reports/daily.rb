module BeerShopWatcher
  module View
    module Reports
      class Daily
        HEADERS = %w[NAME URL YESTERDAYS_QUANTITY ADDED_STOCK SALES_24H].freeze

        attr_reader :data

        def initialize(data)
          @data = data
        end

        def to_view
          { headers: HEADERS, rows: rows(data), name: name }
        end

        private

        def rows(data)
          data.map do |struct|
            [struct.name, struct.url, struct.quantity, struct.added, struct.sales]
          end
        end

        def name
          "daily_beer_shop_#{Time.now.to_i}"
        end
      end
    end
  end
end
