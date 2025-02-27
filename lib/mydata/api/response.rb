# frozen_string_literal: true

module MyDATA
  module API
    class Response
      attr_reader :code
      attr_reader :message
      attr_reader :body
      attr_reader :object
      attr_reader :errors

      @@response_count = 0

      def initialize(response)
        @code = response.code.to_i
        @message = response.message
        @body = response.body
        @object = nil
        @errors = []
      end

      def success?
        @code == 200 && @errors.empty?
      end

      def parse(expecting: MyDATA::Elements::ResponseDoc)
        return unless success?

        @object = MyDATA::Schema::Element.load_from_xml(body, as: expecting)
        unless @object
          @errors << "Failed to parse response as #{expecting}"
          return nil
        end
        if expecting == MyDATA::Schema::ResponseDoc
          # parse the errors
        else
          # Add the errors to the object
        end
        @object
      end
    end
  end
end

