module MyDATA
  module Schema
    module Encoding
      class HTMLEncoder
        def initialize(explainer: nil, pretty: false)
          @html = ""
          @pretty = pretty
          @explainer = explainer || HTMLExplainer.new
        end

        def encode(root)
          @html += "<div class='aade'>"
          @html += "\n  " if @pretty
          @html += "<div class='aade-element'>"
          encode_value(root, title: root.class.get_xml_tag.to_s.titleize, depth: 1)
          @html += "</div>"
          @html += "\n" if @pretty
          @html += "</div>"
          @html
        end

        private

        def encode_value(value, title:, key: nil, explanation: nil, depth: 0)
          if value.is_a? MyDATA::Schema::Element
            @html += "<span class='aade-label'>#{title}</span>"
            @html += " <span class='aade-description'>#{explanation}</span>" if explanation
            encode_sub_elements(value, depth: depth + 1)
            @html += "  " * depth if @pretty
          elsif value.is_a? MyDATA::Schema::ElementArrayProxy
            @html += "<span class='aade-label'>#{title}</span>"
            encode_array(value, title: title, key: key, explanation: explanation, depth: depth + 1)
            @html += "  " * depth if @pretty
          else
            @html += "<span class='aade-label'>#{title}</span>"
            @html += ": <span class='aade-value'>#{value}</span>"
            @html += " <span class='aade-description'>#{explanation}</span>" if explanation
          end
        end

        def encode_sub_elements(element, depth:)
          @html += "\n" + "  " * depth if @pretty
          @html += "<ul>"
          @html += "\n" if @pretty
          element.class.xml_element_metadata.each do |key, metadata|
            value = element.get_xml_element(key) # Read the raw value
            next if value.nil?

            explanation = @explainer.explain(element, key)
            @html += "  " * (depth + 1) if @pretty
            case value
            when MyDATA::Schema::Element
              @html += "<li class='aade-element'>"
            when MyDATA::Schema::ElementArrayProxy
              @html += "<li class='aade-array'>"
            else
              @html += "<li class='aade-attribute'>"
            end
            encode_value(value, title: metadata[:tag].to_s.titleize, key: key, explanation: explanation, depth: depth + 1)
            #@html += "  " * (depth + 1) if @pretty
            @html += "</li>"
            @html += "\n" if @pretty
          end
          @html += "  " * depth if @pretty
          @html += "</ul>"
          @html += "\n" if @pretty
        end

        def encode_array(value, title:, key:, explanation:, depth:)
          @html += "\n" + "  " * depth if @pretty
          @html += "<ul>"
          @html += "\n" if @pretty
          value.each_with_index do |item, i|
            @html += "  " * (depth + 1) if @pretty
            @html += "<li>"
            encode_value(item, title: "#{title}[#{i + 1}]", key: key, explanation: explanation, depth: depth + 1)
            @html += "</li>"
            @html += "\n" if @pretty
          end
          @html += "  " * depth if @pretty
          @html += "</ul>"
          @html += "\n" if @pretty
        end
      end

      class HTMLExplainer
        attr_accessor :currency

        def explain(obj, key)
          helper = "#{key}_description".to_sym
          if obj.respond_to? helper
            return obj.send(helper)
          end

          if value = obj.send(key)
            if key == :currency
              self.currency = value
            elsif currency && (key.to_s.end_with?('amount') || key.to_s.end_with?('_value'))
              return "#{'%.2f' % value} #{currency}"
            end
          end
          nil
        end
      end
    end
  end
end
