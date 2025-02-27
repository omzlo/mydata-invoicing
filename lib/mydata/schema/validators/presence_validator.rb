module MyDATA
  module Schema
      module Validators
        class PresenceValidator < MyDATA::Schema::Validator
          def validate(parent, key, value, options)
            unless [true, false].include? options
              raise ArgumentError, "presence validator expects true or false as argument"
            end

            if options && (value==nil || value=="")
              return "#{key} can't be blank"
            end
            nil
          end
        end
      end
  end
end
