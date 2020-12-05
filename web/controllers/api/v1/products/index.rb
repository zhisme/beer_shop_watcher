require_relative '../base_controller'
require_relative '../../../../presenters/products/index'

module Web
  module Controllers
    module Api
      module V1
        module Products
          class Index < BaseController
            def call(params)
              products = DB[:products].where(Sequel.ilike(:name, "%#{params['product_name']}%")).to_a
              @presenter = Web::Presenters::Products::Index.new(products)

              self
            end

            def render
              @presenter.as_json.to_json
            end
          end
        end
      end
    end
  end
end
