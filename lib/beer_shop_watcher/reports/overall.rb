module BeerShopWatcher
  module Reports
    class Overall
      ProductStruct = Struct.new(:name, :url, :sales)

      def self.call
        new.call
      end

      def call
        scope.map do |record|
          product_result = per_product(record)

          diff = find_diff(product_result)
          build_structure(product_result.first, diff)
        end
      end

      private

      def build_structure(record, diff)
        ProductStruct.new(record[:name], record[:url], diff)
      end

      def find_diff(product_result)
        product_result.each_cons(2).reduce(0) do |acc, (row, next_row)|
          diff = row[:count] - next_row[:count]
          acc += (diff.negative? ? 0 : diff)
          acc
        end
      end

      def scope
        DB[:products]
          .distinct(:name)
      end

      def per_product(record)
        DB[:products]
          .where(Sequel.ilike(:name, "%#{record[:name]}%"))
          .order(Sequel.asc(:id))
          .to_a
      end
    end
  end
end
