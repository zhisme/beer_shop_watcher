require 'caxlsx'

module BeerShopWatcher
  module View
    class Xlsx
      def call(view_models)
        Axlsx::Package.new do |p|
          p.workbook.add_worksheet(name: name) do |sheet|
            sheet.add_row %w[NAME URL YESTERDAYS_QUANTITY SOLD FETCHED_AT]

            view_models.each do |model|
              sheet.add_row([model[:name], model[:url], model[:count], model[:diff_count], model[:created_at]])
            end
          end

          p.serialize(filename)
        end

        filename
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
