module MyDATA
  module Schema
    class Validation
      attr_reader :errors

      def initialize(element)
        @errors = []
        @path = []
        @element = element
      end

      def validate
        push_path(@element.class.get_xml_tag)
        validate_elements(@element)
        pop_path
        valid?
      end

      def valid?
        errors.empty?
      end

      def push_path(*keys)
        @path.push(*keys)
      end

      def pop_path(count = 1)
        @path.pop(count)
      end

      def path_string
        @path.join(" > ")
      end

      def validate_elements(parent)
        unless parent.is_a?(Element)
          @errors << [path_string, "Expected an Element, got '#{parent}' (#{parent.class})"]
          return
        end

        parent.class.xml_element_metadata.each do |key, metadata|
          if value = parent.get_xml_element(key)
            if metadata[:multiple]
              value.each_with_index do |item, index|
                push_path(key, index)
                validate_element(item, metadata: metadata)
                pop_path(2)
              end
            else
              push_path(key)
              validate_element(value, metadata: metadata)
              pop_path
            end

            run_custom_validations(parent, key, value)
          end
        end
      end

      def validate_element(value, metadata:)
        type = metadata[:type]

        if type.nil?
          type = Element.find_matching_subclass(metadata[:key]) || :string
        end

        if type.is_a?(Symbol)
          case type
          when :decimal
            unless value.is_a?(Numeric)
              @errors << [path_string, "Expected a Float or BigDecimal, got '#{value}' (#{value.class})"]
            end
          when :integer
            unless value.is_a?(Integer)
              @errors << [path_string, "Expected an Integer, got '#{value}' (#{value.class})"]
            end
          when :time
            unless value.is_a?(Time)
              @errors << [path_string, "Expected a Time, got '#{value}' (#{value.class})"]
            end
          when :date
            unless value.is_a?(Date)
              @errors << path_string + "Expected a Date, got '#{value}' (#{value.class})"
            end
          when :string
            unless value.is_a?(String)
              @errors << [path_string, "Expected a String, got '#{value}' (#{value.class})"]
            end
          when :boolean
            unless [true, false].include?(value)
              @errors << [path_string, "Expected a Boolean, got '#{value}' (#{value.class})"]
            end
          end
        elsif type < Type
          if value.respond_to?(:validate)
            if error = value.validate
              @errors << [path_string, error]
            end
          end
        elsif type < Element
          validate_elements(value)
        end
      end

      def run_custom_validations(parent, key, value)
        if validators = parent.class.xml_element_validators[key]
          validators.each do |validator_key, validator_params|
            process_validation(validator_key, validator_params, parent, key, value)
          end
        end
      end

      def process_validation(validator_key, validator_params, parent, key, value)
        validator = MyDATA::Schema::Validator.validator_for(validator_key)
        raise ArgumentError, "Unknown validator '#{validator_key} for '#{key}' in '#{parent.class}'" unless validator
        error = validator.new.validate(parent, key, value, validator_params)
        @errors << [path_string, error] if error
      end
    end
  end
end
