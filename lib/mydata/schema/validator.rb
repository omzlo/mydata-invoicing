module MyDATA
  module Schema
    class Validator
      @@subclasses = {}

      def self.inherited(subclass)
        key = subclass.to_s.demodulize.underscore
        return unless key.end_with?('_validator')
        key = key.chomp('_validator').to_sym
        @@subclasses[key] = subclass
      end

      def self.validator_for(key)
        @@subclasses[key]
      end

      def validate(parent, key, value, options)
        raise NotImplementedError
      end
    end
  end
end
