require_relative '../base_controller'

module Web
  module Controllers
    module Products
      class Index < Web::Controllers::BaseController
        def call(_params)
          @template = :index
          @context[:products] = DB[:products].order(Sequel.desc(:id)).limit(10).to_a

          self
        end
      end
    end
  end
end
