module Web
  module Controllers
    module Api
      module V1
        class BaseController
          attr_reader :params, :items

          def self.call(params)
            new(params).call
          end

          def call(*)
            raise 'Implement!'
          end

          def render
            presenter.new(items).as_json.to_json
          end

          private

          def initialize(params)
            @params = params
            @items = []
          end
        end
      end
    end
  end
end
