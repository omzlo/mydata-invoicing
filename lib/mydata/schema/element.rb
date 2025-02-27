# frozen_string_literal: true

module MyDATA # :nodoc:
  # XML elements used for parsing MyData XML
  module Schema
    # Base class element for MyData parser
    class Element
      @@subclasses = {}

      def initialize(**args)
        assign_xml_elements(**args)
      end

      def self.inherited(subclass)
        key = subclass.to_s.demodulize.underscore.to_sym
        if @@subclasses.key?(key)
          raise ArgumentError, "Cannot register subclass #{subclass} with key #{key}, it is already registered by #{@@subclasses[key]}"
        end
        @@subclasses[key] = subclass
        super
      end

      def self.subclasses
        @@subclasses.values
      end

      def self.subclass_keys
        @@subclasses.keys
      end

      def self.find_matching_subclass(symbol)
        @@subclasses[symbol]
      end

      # Returns the tag for the element
      def self.get_xml_tag
        if singleton_class.instance_variable_defined? :@xml_tag
          singleton_class.instance_variable_get(:@xml_tag)
        else
          name.demodulize.camelcase(:lower)
        end
      end

      # Define the tag for the XML
      def self.xml_tag(tag)
        singleton_class.instance_variable_set(:@xml_tag, tag)
      end

      # Define the schemas for the XML
      def self.xml_schema(url = nil, **args)
        if url
          xml_schema_list[:default] = url
        end
        args.each do |key, value|
          xml_schema_list[key.to_s] = value
        end
      end

      def self.xml_schema_list
        if singleton_class.instance_variable_defined?(:@xml_schema_list)
          schemas = singleton_class.instance_variable_get(:@xml_schema_list)
        else
          schemas = superclass.respond_to?(:xml_schema_list) ? superclass.xml_schema_list.dup : {}
          singleton_class.instance_variable_set(:@xml_schema_list, schemas)
        end
        schemas
      end

      # Define a description for an attribute, which will be notably used in the
      # HTML representation of the object.
      #
      # == Parameters:
      #
      # * +attribute+ - The attribute to describe
      # * +method_name+ - The method to call to get the description
      # * +block+ - A block to call to get the description (if no method_name is provided)
      #
      # == Example:
      #
      #  class Person < Element
      #     xml_element :name
      #
      #     describe :name do
      #       "The name of the person"
      #     end
      #  end
      def self.describe(attribute, method_name = nil, &block)
        if method_name
          if block_given?
            raise ArgumentError, "Can't provide both a method_name and a block to describe"
          end
          define_method("#{attribute}_description") do
            send(method_name)
          end
        elsif block_given?
          define_method("#{attribute}_description") do
            instance_exec(&block)
          end
        else
          raise ArgumentError, "Either a method_name or block must be provided to describe"
        end
      end

      # This returns an hash that maps the name of the element to its descriptor
      #
      # The hash key of the element is a string, incuding the namespace, and the descriptor is a hash with the
      # following attributes:
      #
      # * +name+ - The name of the element, as a symbol, without the namespace
      # * +tag+ - The XML tag of the element, as a string
      # * +namespace+ - The namespace of the element, as a string
      # * +type+ - The type of the element, as a symbol, a class or nil
      # * +multiple+ - Whether the element can appear multiple times, and should be stored as an array
      #
      # == Example:
      #
      # :first_name => {
      #   :key => :first_name,
      #   :namespaced_tag => "firstName",
      #   :tag => "firstName",
      #   :namespace => nil,
      #   :type => :string,
      #   :multiple => false
      # },
      # :description => {
      #   :key=>:description,
      #   :namespaced_tag=>"og:description",
      #   :tag=>"description",
      #   :namespace=>"og",
      #   :type=>nil,
      #   :multiple=>false
      # }
      #
      def self.xml_element_metadata
        if singleton_class.instance_variable_defined?(:@xml_element_metadata)
          elements = singleton_class.instance_variable_get(:@xml_element_metadata)
        else
          # Just in case we're subclassing a class that has xml_elements defined. For example, when say that
          # "Counterpart" is a subclass of "Party", we want to inherit the xml_elements from "Party".
          elements = superclass.respond_to?(:xml_element_metadata) ? superclass.xml_element_metadata.dup : {}
          singleton_class.instance_variable_set(:@xml_element_metadata, elements)
        end
        elements
      end

      def self.xml_namespaced_tag_to_key
        if singleton_class.instance_variable_defined?(:@xml_namespaced_tag_to_key)
          mapping = singleton_class.instance_variable_get(:@xml_namespaced_tag_to_key)
        else
          # Same subclassing logic as above in xml_element_metadata
          mapping = superclass.respond_to?(:xml_namespaced_tag_to_key) ? superclass.xml_namespaced_tag_to_key.dup : {}
          singleton_class.instance_variable_set(:@xml_namespaced_tag_to_key, mapping)
        end
        mapping
      end

      def self.xml_element_validators
        if singleton_class.instance_variable_defined?(:@xml_element_validators)
          validators = singleton_class.instance_variable_get(:@xml_element_validators)
        else
          validators = {}
          singleton_class.instance_variable_set(:@xml_element_validators, validators)
        end
        validators
      end

      # Define an XML element for the class
      #
      # == Parameters:
      #
      # * +key+ - The identifier of the element in the class, as a symbol, without any namespace.
      # * +type+ - The type of the element, as a symbol or a class
      # * +namespace+ - The namespace of the element, as a string
      # * +tag+ - The tag of the element, as a string
      # * +multiple+ - Whether the element can appear multiple times, and should be stored as an array
      #
      #
      def self.xml_element(key, type = nil, namespace: nil, tag: nil, multiple: false)
        tag ||= key.to_s.camelcase(:lower)
        key = key.to_sym

        define_method(key.to_s) do
          get_xml_element(key)
        end

        define_method("#{key}=") do |value|
          assign_xml_element(key, value)
        end

        register_xml_element(
          key: key,
          tag: tag,
          namespace: namespace,
          type: type,
          multiple: multiple,
        )
      end

      def self.namespaced_tag(tag, namespace)
        namespace ? "#{namespace}:#{tag}" : tag.to_s
      end

      # Assign an value to an element
      #
      # == Parameters:
      # * +key+ - The key of the element to assign
      # * +value+ - The value to assign to the element.
      #
      # When the value is a symbol, it will be transformed into a constant based on the definition found in the
      # MyDATA::Constants module.
      # When the value is a hash, it will be transformed into an instance of the class that matches the key.
      # When the value is assigned to an element that can appear multiple times, it will be appended to the existing
      # value, unless the value is an array already.
      #
      def assign_xml_element(key, value)
        metadata = self.class.get_xml_element_metadata_by_key(key)

        # Raise an error if the key is not found in the metadata
        raise ArgumentError, "Unknown element '#{key}' in #{self.class}" unless metadata

        element_class = metadata[:type] || MyDATA::Schema::Element.find_matching_subclass(key) || String

        if metadata[:multiple]
          if value.is_a?(Array)
            value = ElementArrayProxy.new(element_class, value)
          else
            raise ArgumentError, "Cannot assign a single value to '#{key}' in #{self.class}, it is an array-like element"
          end
        end

        # Preprocess symbols as constants and hashes as elements.
        case value
        when Symbol
          value = MyDATA::Constants.validate!(value)
        when Hash
          value = element_class.new(**value)
        end

        # Finally, we write the value to the instance variable
        write_xml_element(key, value)
      end

      # Assign multiple elements at once
      #
      # == Parameters:
      # * +args+ - A hash of key-value pairs to assign to the object
      #
      # This method will call assign_xml_element for each key-value pair in the hash.
      #
      def assign_xml_elements(**args)
        args.each do |key, value|
          assign_xml_element(key, value)
        end
      end

      # Get the value of an element
      #
      # == Parameters:
      #
      # * +key+ - The key of the element to get
      #
      def get_xml_element(key)
        metadata = self.class.get_xml_element_metadata_by_key(key)

        value = read_xml_element(key)

        if metadata[:multiple] && value.nil?
          element_class = metadata[:type] || MyDATA::Schema::Element.find_matching_subclass(key) || String
          value = write_xml_element(key, ElementArrayProxy.new(element_class))
        end
        value
      end

      def self.get_xml_element_metadata_by_key(key)
        xml_element_metadata[key] || raise(ArgumentError, "Unknown element '#{key}' in #{self}")
      end

      def self.get_xml_element_metadata_by_namespaced_tag(ns_tag)
        if key = xml_namespaced_tag_to_key[ns_tag]
          get_xml_element_metadata_by_key(key)
        else
          nil
        end
      end

      # Validate the object against the schema
      # Returns true if the object is valid, false otherwise
      #
      def validate
        validator = MyDATA::Schema::Validation.new(self)
        validator.validate
        @validation_errors = validator.errors
        validator.valid?
      end

      # Returns the validation errors as an array if the object is not valid
      # Returns an empty array if the object is valid
      def validation_errors
        @validation_errors || []
      end

      # Returns true if the object is valid, false otherwise
      # This method will call validate if it hasn't been called before
      def valid?
        validate
      end

      # Declare a validation for an element
      #
      # == Parameters:
      # * +key+ - The key of the element to validate (as a symbol)
      # * +options+ - A hash of options to validate the element
      #
      # == Example:
      #
      # class Person < Element
      #  xml_element :name
      #
      #  validates :name, presence: true
      # end
      def self.validates(key, **options)
        existing_validators = xml_element_validators[key] || {}
        xml_element_validators[key] = existing_validators.merge(options)
      end

      # Convert element to XML
      # Returns a string with the XML representation of the object
      def to_xml
        MyDATA::Schema::Encoding::XMLEncoder.new.encode(self)
      end

      # Convert element to HTML
      # Returns a string with the HTML representation of the object
      def to_html
        MyDATA::Schema::Encoding::HTMLEncoder.new.encode(self)
      end

      # Load an object from an XML string
      #
      # == Parameters:
      # * +xml+ - The XML string to load the object from
      # * +as+ - The class to load the object as
      # == Returns:
      # An instance of the class loaded from
      #
      def self.load_from_xml(xml, as:)
        MyDATA::Schema::Encoding::XMLDecoder.new(xml).decode(as)
      end

      protected

      def write_xml_element(key, value)
        self.class.get_xml_element_metadata_by_key(key)

        instance_variable_set("@#{key}", value)
      end

      def read_xml_element(key)
        self.class.get_xml_element_metadata_by_key(key)

        instance_variable_get("@#{key}")
      end

      private

      ALLOWED_TYPE_SYMBOLS =[:decimal, :integer, :time, :date, :string, :boolean].freeze
      def self.validate_type(type)
        case type
        when NilClass
          return
        when Symbol
          unless ALLOWED_TYPE_SYMBOLS.include?(type)
            raise ArgumentError, "Type must be one of #{ALLOWED_TYPE_SYMBOLS.join(', ')}, got '#{type}'"
          end
          return
        when Class
          return
        else
          raise ArgumentError, "Type must be a Constant, a symbol or nil"
        end
      end

      def self.register_xml_element(key:, tag:, namespace:, type:, multiple:)
        namespaced_tag = namespaced_tag(tag, namespace)

        # We add the value to the xml element metadata
        xml_element_metadata[key] = {
          key: key,
          namespaced_tag: namespaced_tag,
          tag: tag,
          namespace: namespace,
          type: type,
          multiple: multiple,
        }

        # We add the key to the xml element keys
        xml_namespaced_tag_to_key[namespaced_tag] = key
      end
    end
  end
end
