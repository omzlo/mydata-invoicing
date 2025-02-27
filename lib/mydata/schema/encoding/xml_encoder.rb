module MyDATA
  module Schema
    module Encoding
      class XMLEncoder
        def initialize
          @xml = ""
        end

        def encode(element)
          if @xml.empty?
            @xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
          end
          attributes = {}
          if element.class.xml_schema_list.any?
            if element.class.xml_schema_list[:default]
              attributes["xmlns"] = element.class.xml_schema_list[:default]
            end
            element.class.xml_schema_list.each do |key, value|
              attributes["xmlns:#{key}"] = value unless key == :default
            end
          end
          encode_element(element.class.get_xml_tag, element, depth: 0, attributes: attributes)
          @xml
        end

        private

        def encode_element(fully_qualified_tag, element, depth: 0, attributes: {})
          @xml += "  " * depth
          @xml += "<#{fully_qualified_tag}"
          attributes.each do |key, value|
            @xml += " #{key}=\"#{value}\""
          end
          @xml += ">\n"
          element.class.xml_element_metadata.each do |key, metadata|
            if value = element.get_xml_element(key) # raw value
              encode_sub_element(metadata[:namespaced_tag], value, depth: depth + 1, type: metadata[:type])
            end
          end
          @xml += "  " * depth
          @xml += "</#{fully_qualified_tag}>\n"
        end

        def encode_sub_element(fully_qualified_tag, value, depth:, type: nil)
          if value.is_a? Element
            encode_element(fully_qualified_tag, value, depth: depth)
          elsif value.is_a? ElementArrayProxy
            value.each do |item|
              encode_sub_element(fully_qualified_tag, item, depth: depth)
            end
          else
            case value
            when BigDecimal, Float
              value = ("%.2f" % value.to_d)
            when Time
              value = value.strftime("%H:%M:%S")
            end
            @xml += "  " * depth
            @xml += "<#{fully_qualified_tag}>#{value}</#{fully_qualified_tag}>\n"
          end
        end
      end
    end
  end
end
