require_relative '../base_controller'
require_relative '../../../../presenters/products/index'

module Web
  module Controllers
    module Api
      module V1
        module Products
          class Index < BaseController
            def call
              @items = DB[:products].where(
                Sequel.ilike(:name, "%#{params['product_name']}%")
              )

              @items = with_range if params['start_date']
              @items = items.to_a

              self
            end

            private

            def presenter
              Web::Presenters::Products::Index
            end

            def with_range
              items
                .where(Sequel.lit('created_at > ?', params['start_date']))
                .where(Sequel.lit('created_at < ?', params['end_date']))
            end
          end
        end
      end
    end
  end
end
