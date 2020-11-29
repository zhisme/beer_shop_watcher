module BeerShopWatcher
  module Reports
    class Daily
      RowStruct = Struct.new(:name, :url, :quantity, :added, :sales)

      def self.call
        new.call
      end

      def call
        scope.map do |record|
          product_result = per_product(record)

          diff = find_diff(product_result.first, product_result.last)
          build_structure(product_result.first, diff)
        end
      end

      private

      def build_structure(record, diff)
        added, sales = diff.negative? ? [diff, 0] : [0, diff]

        RowStruct.new(record[:name], record[:url], record[:count], added, sales)
      end

      def find_diff(first_scrape, last_scrape)
        first_scrape[:count] - last_scrape[:count]
      end

      def scope
        DB[:products]
          .where(Sequel.lit('created_at > ?', yesterday))
          .where(Sequel.lit('created_at < ?', today))
          .distinct(:name)
      end

      def per_product(record)
        DB[:products]
          .where(Sequel.ilike(:name, "%#{record[:name]}%"))
          .where(Sequel.lit('created_at > ?', yesterday))
          .where(Sequel.lit('created_at < ?', today))
          .order(Sequel.asc(:id))
          .to_a
      end

      def yesterday
        Date.today.prev_day.to_time
      end

      def today
        Date.today.to_time
      end
    end
  end
end
