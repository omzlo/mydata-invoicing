module MyDATA
  module Schema
    class Type
      def cast(value)
        value
      end

      def serialize(value)
        value
      end
    end
  end
end
