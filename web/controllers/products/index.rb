require_relative '../base_controller'

module Web
  module Controllers
    module Products
      class Index < Web::Controllers::BaseController
        def call(_params)
          @template = :index
          @context[:product_names] = DB[:products].distinct.select(:name).order(Sequel.asc(:name)).to_a.map { |row| row[:name] }

          self
        end
      end
    end
  end
end
