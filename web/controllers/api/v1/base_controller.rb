module Web
  module Controllers
    module Api
      module V1
        class BaseController
          def self.call(*args)
            new.call(*args)
          end

          def call(*)
            raise 'Implement!'
          end
        end
      end
    end
  end
end
