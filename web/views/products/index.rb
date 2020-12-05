module Web
  module Views
    module Products
      class Index
        attr_reader :products, :product_names, :page_title

        def self.call(context)
          new.call(context)
        end

        def call(context)
          @page_title = 'Diagram'
          @product_names = context[:product_names]

          self
        end
      end
    end
  end
end
