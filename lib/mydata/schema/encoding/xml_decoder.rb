module MyDATA
  module Schema
    module Encoding
      class ParseError < StandardError; end

      class XMLDecoder
        attr_reader :errors

        def initialize(xml)
          if xml.is_a?(String)
            @root = Nokogiri::XML(xml).element_children[0]
          else
            @root = xml
          end
          @errors = []
        end

        def decode(klass)
          xml_name = Element.namespaced_tag(@root.name, @root.namespace&.prefix)
          if klass.get_xml_tag != xml_name
            return add_error("Expected XML element <#{klass.get_xml_tag}>, but got <#{xml_name}>", @root)
          end
          decode_element(klass, @root)
        end

        def decode!(klass)
          result = decode(klass)
          raise ParseError, @errors.join("\n") unless errors.empty?
          result
        end

        private

        def add_error(message, node)
          @errors << "#{message}, at #{node.path} on line #{node.line}"
          false
        end

        def decode_element(klass, xml)
          klass.new.tap do |instance|
            xml.element_children.each { |child| decode_child(instance, child) }
          end
        end

        def decode_child(instance, xml)
          child_name = Element.namespaced_tag(xml.name, xml.namespace&.prefix)

          element_metadata = instance.class.get_xml_element_metadata_by_namespaced_tag(child_name)

          unless element_metadata
            return add_error("Unrecognized XML element <#{child_name}>", xml)
          end

          klass = guess_class(element_metadata)
          value = xml.children[0]&.text
          key = element_metadata[:key]

          if klass.nil? # Assume string if no type is specified
            value = value.to_s
          elsif klass.is_a?(Symbol)
            return if value.nil? # Ignore empty elements
            case klass
            when :decimal
              value = value.to_d
            when :integer
              value = value.to_i
            when :time
              value = Time.parse(value)
            when :date
              value = Date.parse(value)
            when :string
              value = value.to_s
            when :boolean
              value = value.downcase == 'true'
            else
              return add_error("Invalid type metadata '#{klass}' for element #{child_name}", xml)
            end
          elsif klass < Element
            value = decode_element(klass, xml)
          elsif klass < Type
            value = klass.new.cast(value)
          else
            return add_error("Invalid type metadata for element #{child_name}", xml)
          end

          if element_metadata[:multiple]
            instance.get_xml_element(key) << value
          else
            instance.assign_xml_element(key, value)
          end
        end

        def guess_class(element_metadata)
          klass = element_metadata[:type]
          klass = Element.find_matching_subclass(element_metadata[:key]) if klass.nil?
          klass
        end
      end
    end
  end
end
