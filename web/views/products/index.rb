module Web
  module Views
    module Products
      class Index
        attr_reader :products, :product_names, :page_title, :min_date, :max_date

        def self.call(context)
          new.call(context)
        end

        def call(context)
          @page_title = 'Diagram'
          @product_names = context[:product_names]
          @min_date = context[:min_date]
          @max_date = context[:max_date]

          self
        end
      end
    end
  end
end
