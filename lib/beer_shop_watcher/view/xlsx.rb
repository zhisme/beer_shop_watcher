require 'caxlsx'

module BeerShopWatcher
  module View
    class Xlsx
      def self.call(report_view:)
        new(report_view).call
      end

      def call
        Axlsx::Package.new do |p|
          p.workbook.add_worksheet(name: view[:name]) do |sheet|
            sheet.add_row(view[:headers])

            view[:rows].each { |row| sheet.add_row(row) }
          end

          p.serialize(filename)
        end

        File.new(filename)
      end

      private

      attr_reader :view

      def initialize(report_view)
        @view = report_view.to_view
      end

      def filename
        "tmp/#{view[:name]}.xlsx"
      end
    end
  end
end
