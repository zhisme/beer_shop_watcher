module Web
  module Controllers
    class BaseController
      attr_reader :context, :template

      def self.call(*args)
        new.call(*args)
      end

      def call(*)
        raise 'Implement!'
      end

      def initialize
        @context = {}
        @template = nil
      end
    end
  end
end
