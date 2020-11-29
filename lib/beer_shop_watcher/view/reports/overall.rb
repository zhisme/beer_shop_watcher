module BeerShopWatcher
  module View
    module Reports
      class Overall
        HEADERS = %w[NAME URL SALES].freeze

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
            [struct.name, struct.url, struct.sales]
          end
        end

        def name
          "overall_beer_shop_#{Time.now.to_i}"
        end
      end
    end
  end
end
