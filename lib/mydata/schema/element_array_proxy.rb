module MyDATA
  module Schema
    class ElementArrayProxy
      def initialize(element_class, values = [])
        @element_class = element_class
        @elements = values.map { |value| convert_value(value) }
      end

      def [](index)
        @elements[index]
      end

      def []=(index, value)
        @elements[index] = convert_value(value)
      end

      def <<(value)
        @elements << convert_value(value)
      end

      def each(&block)
        @elements.each(&block)
      end

      def each_with_index(&block)
        @elements.each_with_index(&block)
      end

      def first
        @elements.first
      end

      def last
        @elements.last
      end

      def size
        @elements.size
      end

      def to_a
        @elements
      end

      def empty?
        @elements.empty?
      end

      def any?
        @elements.any?
      end

      def push(value)
        @elements.push(convert_value(value))
      end

      def pop
        @elements.pop
      end

      private

      def convert_value(value)
        if value.is_a? Hash
          @element_class.new(**value)
        else
          value
        end
      end
    end
  end
end
