require 'caxlsx'

module BeerShopWatcher
  module View
    class Xlsx
      def self.call(data:)
        new.call(data)
      end

      def call(data)
        Axlsx::Package.new do |p|
          p.workbook.add_worksheet(name: name) do |sheet|
            sheet.add_row %w[NAME URL YESTERDAYS_QUANTITY ADDED_STOCK SALES_24H]

            data.each do |struct|
              sheet.add_row([struct.name, struct.url, struct.quantity, struct.added, struct.sales])
            end
          end

          p.serialize(filename)
        end

        File.new(filename)
      end

      private

      def filename
        "tmp/#{name}.xlsx"
      end

      def name
        "beer_shop_#{Time.now.to_i}"
      end
    end
  end
end
