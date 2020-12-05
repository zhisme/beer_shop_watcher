module Web
  module Presenters
    module Products
      class Index
        def as_json
          {
            products: diagram_format
          }
        end

        def initialize(products)
          @products = products
        end

        attr_reader :products

        private

        def diagram_format
          products.reduce([%w[date sales]]) do |acc, product|
            acc << [product[:created_at].to_s, product[:count]]
          end
        end
      end
    end
  end
end
