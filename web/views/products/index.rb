module Web
  module Views
    module Products
      class Index
        attr_reader :products, :page_title

        def self.call(context)
          new.call(context)
        end

        def call(context)
          @page_title = 'Diagram'
          @products = context[:products]

          self
        end
      end
    end
  end
end
