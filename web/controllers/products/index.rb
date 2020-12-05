require_relative '../base_controller'

module Web
  module Controllers
    module Products
      class Index < Web::Controllers::BaseController
        def call(_params)
          @template = :index
          @context[:min_date] = DB[:products].order(Sequel.asc(:created_at)).limit(1).to_a.first[:created_at].to_date.to_s
          @context[:max_date] = DB[:products].order(Sequel.desc(:created_at)).limit(1).to_a.first[:created_at].to_date.to_s
          @context[:product_names] = DB[:products].distinct.select(:name).order(Sequel.asc(:name)).to_a.map { |row| row[:name] }

          self
        end
      end
    end
  end
end
