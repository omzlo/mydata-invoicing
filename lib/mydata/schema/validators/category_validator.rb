module MyDATA
  module Schema
    module Validators
      class CategoryValidator < MyDATA::Schema::Validator
        def validate(parent, key, value, options)
          unless options.is_a?(Symbol)
            raise ArgumentError, "CategoryValidator expects a symbol as argument"
          end

          unless MyDATA::Constants.lookup_by_value(value, category: options)
            return "Invalid value '#{value}' for key '#{key}' for category '#{options}'"
          end
          nil
        end
      end
    end
  end
end
