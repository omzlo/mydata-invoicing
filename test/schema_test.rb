# frozen_string_literal: true

require "test_helper"

class SchemaTest < Minitest::Test
  XML_STRING = <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<foo xmlns:og="https://ogp.me/ns#">
  <bar>
    <baz>42</baz>
    <qux>1</qux>
    <qux>2</qux>
    <qux>3</qux>
  </bar>
  <name>John</name>
  <og:description>Test</og:description>
</foo>
XML


  class Foo < MyDATA::Schema::Element
    xml_schema og: "https://ogp.me/ns#"

    xml_element :bar
    xml_element :name, :string
    xml_element :description, namespace: "og"

    describe :name do
      "The name: #{self.name}"
    end
  end

  class Bar < MyDATA::Schema::Element
    xml_element :baz, :integer
    xml_element :qux, :integer, multiple: true
  end

  class Only42 < MyDATA::Schema::Type
    def cast(value)
      value = value.to_i
      raise ArgumentError, "Must be 42" unless value == 42
      value
    end
    def serialize(value)
      value.to_s
    end
  end

  class Special < MyDATA::Schema::Element
    xml_element :value, Only42
  end


  # TESTS

  def test_schema_element
    assert MyDATA::Schema::Element.subclasses.include?(Foo)
    assert MyDATA::Schema::Element.subclasses.include?(Bar)
  end

  def test_new_element
    element = Foo.new
    assert element.respond_to?(:name)
    assert element.respond_to?(:name=)
    assert element.respond_to?(:bar)
    assert element.respond_to?(:bar=)
    assert element.respond_to?(:description)
    assert element.respond_to?(:description=)
    element.name = "John"
    assert_equal "John", element.name
  end

  def test_decode_element
    source = "<foo><bar><baz>42</baz><qux>1</qux><qux>2</qux><qux>3</qux></bar><name>John</name></foo>"

    foo = MyDATA::Schema::Element.load_from_xml(source, as: Foo)
    assert foo
    assert foo.is_a?(Foo)
    assert foo.bar.is_a?(Bar)
    assert_equal 42, foo.bar.baz
    assert_equal [1, 2, 3], foo.bar.qux.to_a
    assert_equal "John", foo.name
    assert_equal "The name: John", foo.name_description
  end

  class Everything < MyDATA::Schema::Element
    xml_element :unspecified
    xml_element :string_value, :string
    xml_element :integer_value, :integer
    xml_element :decimal_value, :decimal
    xml_element :boolean_value, :boolean
    xml_element :date_value, :date
    xml_element :time_value, :time
    xml_element :multi_string_value, :string, multiple: true
    xml_element :multi_integer_value, :integer, multiple: true
    xml_element :multi_decimal_value, :decimal, multiple: true
    xml_element :multi_boolean_value, :boolean, multiple: true
    xml_element :multi_date_value, :date, multiple: true
    xml_element :multi_time_value, :time, multiple: true
  end

  def test_decode_element_all_types
    source = <<~XML_SOURCE
    <?xml version="1.0" encoding="UTF-8"?>
    <everything>
      <unspecified>test</unspecified>
      <stringValue>test</stringValue>
      <integerValue>42</integerValue>
      <decimalValue>42.42</decimalValue>
      <booleanValue>true</booleanValue>
      <dateValue>2021-02-01</dateValue>
      <timeValue>2024-03-02 12:13:14</timeValue>
      <multiStringValue>test1</multiStringValue>
      <multiStringValue>test2</multiStringValue>
      <multiIntegerValue>42</multiIntegerValue>
      <multiIntegerValue>43</multiIntegerValue>
      <multiDecimalValue>42.42</multiDecimalValue>
      <multiDecimalValue>43.43</multiDecimalValue>
      <multiBooleanValue>true</multiBooleanValue>
      <multiBooleanValue>false</multiBooleanValue>
      <multiDateValue>2021-02-01</multiDateValue>
      <multiDateValue>2021-02-02</multiDateValue>
      <multiTimeValue>2024-03-02 12:13:14</multiTimeValue>
      <multiTimeValue>2023-02-01 15:16:17</multiTimeValue>
    </everything>
    XML_SOURCE

    everything = MyDATA::Schema::Element.load_from_xml(source, as: Everything)
    assert everything
    assert everything.is_a?(Everything)
    assert_equal "test", everything.unspecified
    assert_equal "test", everything.string_value
    assert_equal 42, everything.integer_value
    assert_equal 42.42, everything.decimal_value
    assert_equal true, everything.boolean_value
    assert_equal Date.new(2021, 2, 1), everything.date_value
    assert_equal Time.new(2024, 3, 2, 12, 13, 14), everything.time_value

    assert_equal ["test1", "test2"], everything.multi_string_value.to_a
    assert_equal [42, 43], everything.multi_integer_value.to_a
    assert_equal [42.42, 43.43], everything.multi_decimal_value.to_a
    assert_equal [true, false], everything.multi_boolean_value.to_a
    assert_equal [Date.new(2021, 2, 1), Date.new(2021, 2, 2)],
      everything.multi_date_value.to_a
    assert_equal [Time.new(2024, 3, 2, 12, 13, 14), Time.new(2023, 2, 1, 15, 16, 17)],
      everything.multi_time_value.to_a
  end

  def test_decode_and_encode_element
    foo = MyDATA::Schema::Element.load_from_xml(XML_STRING, as: Foo)

    assert foo
    assert foo.is_a?(Foo)
    assert foo.bar.is_a?(Bar)
    assert_equal 42, foo.bar.baz
    assert_equal [1, 2, 3], foo.bar.qux.to_a
    assert_equal "John", foo.name
    assert_equal "The name: John", foo.name_description
    assert_equal "Test", foo.description

    assert_equal XML_STRING, foo.to_xml
  end

  def test_build_element
    foo = Foo.new(
      bar: Bar.new(
        baz: 42,
        qux: [1, 2, 3],
      ),
      name: "John",
      description: "Test"
    )

    assert foo
    assert foo.is_a?(Foo)
    assert foo.bar.is_a?(Bar)
    assert_equal 42, foo.bar.baz
    assert_equal [1, 2, 3], foo.bar.qux.to_a
    assert_equal "John", foo.name
    assert_equal "Test", foo.description
  end

  def test_assign_element_multiple
    foo = Bar.new
    foo.qux = [1, 2, 3]
    assert_equal [1, 2, 3], foo.qux.to_a

    foo.qux << 4
    assert_equal [1, 2, 3, 4], foo.qux.to_a

    foo.qux = [5]
    assert_equal [5], foo.qux.to_a

    assert_raises ArgumentError do
      foo.qux = 6
    end

    foo.assign_xml_element(:qux, [5, 6, 7])
    assert_equal [5, 6, 7], foo.qux.to_a

    assert_raises ArgumentError do
      foo.assign_xml_element(:qux, 8)
      assert_equal [5, 6, 7, 8], foo.qux.to_a
    end

    foo.assign_xml_element(:qux, [9])
    assert_equal [9], foo.qux.to_a
  end

  def test_validate_element_success
    foo = Foo.new(
      bar: Bar.new(
        baz: 42,
        qux: [1, 2, 3],
      ),
      name: "John",
      description: "Test"
    )

    assert foo.valid?
    assert_empty foo.validation_errors
  end

  def test_validate_element_errors
    foo = Foo.new(
      bar: Bar.new(
        baz: "42",
        qux: [1, 2, 3],
      ),
      name: 123,
      description: "Test"
    )

    refute foo.valid?
    assert_equal 2, foo.validation_errors.size
    assert_equal ["foo > bar > baz", "Expected an Integer, got '42' (String)"], foo.validation_errors[0]
    assert_equal ["foo > name", "Expected a String, got '123' (Integer)"], foo.validation_errors[1]
  end

  def test_decode_special
    source = "<special><value>42</value></special>"

    special = MyDATA::Schema::Element.load_from_xml(source, as: Special)
    assert special
    assert special.is_a?(Special)
    assert_equal 42, special.value
  end

  def test_decode_special_fail
    source = "<special><value>43</value></special>"

    assert_raises ArgumentError do
      MyDATA::Schema::Element.load_from_xml(source, as: Special)
    end
  end

  def test_decode_unknown_sub_element
    source = "<foo><bar><bad>42</bad></bar><name>John</name></foo>"

    decoder = MyDATA::Schema::Encoding::XMLDecoder.new(source)
    assert_raises MyDATA::Schema::Encoding::ParseError do
      decoder.decode!(Foo)
    end
    assert_equal 1, decoder.errors.size
    assert decoder.errors.first.include?("Unrecognized XML element <bad>")
  end

  def test_decode_unknown_sub_element_without_exception
    source = "<foo><bar><bad>42</bad></bar><name>John</name></foo>"

    decoder = MyDATA::Schema::Encoding::XMLDecoder.new(source)
    foo = decoder.decode(Foo)
    assert_equal 1, decoder.errors.size
    assert decoder.errors.first.include?("Unrecognized XML element <bad>")
    assert foo
    assert foo.is_a?(Foo)
  end

  def test_decode_unknown_root_element
    source = "<error>test</error>"

    decoder = MyDATA::Schema::Encoding::XMLDecoder.new(source)
    result = decoder.decode(Foo)
    refute result
  end

  def test_encode_element
    bar = Bar.new
    bar.baz = 42
    bar.qux = [1, 2, 3]
    foo = Foo.new
    foo.bar = bar
    foo.name = "John"
    foo.description = "Test"

    assert_equal XML_STRING, foo.to_xml
  end

  EXPECTED_HTML = "<div class='aade'><div class='aade-element'><span class='aade-label'>Foo</span><ul><li class='aade-element'><span class='aade-label'>Bar</span><ul><li class='aade-attribute'><span class='aade-label'>Baz</span>: <span class='aade-value'>42</span></li><li class='aade-array'><span class='aade-label'>Qux</span><ul><li><span class='aade-label'>Qux[1]</span>: <span class='aade-value'>1</span></li><li><span class='aade-label'>Qux[2]</span>: <span class='aade-value'>2</span></li><li><span class='aade-label'>Qux[3]</span>: <span class='aade-value'>3</span></li></ul></li></ul></li><li class='aade-attribute'><span class='aade-label'>Name</span>: <span class='aade-value'>John</span> <span class='aade-description'>The name: John</span></li></ul></div></div>"

  def test_encode_to_html
    bar = Bar.new
    bar.baz = 42
    bar.qux = [1, 2, 3]
    foo = Foo.new
    foo.bar = bar
    foo.name = "John"

    assert_equal EXPECTED_HTML, foo.to_html
  end

  def test_decode_empty_value
    source = "<foo><bar><baz></baz><qux>1</qux><qux>2</qux><qux>3</qux></bar><name>John</name></foo>"

    foo = MyDATA::Schema::Element.load_from_xml(source, as: Foo)
    assert foo
    assert foo.is_a?(Foo)
    assert_equal "John", foo.name
    assert_nil foo.bar.baz
  end

  def test_encode_from_hash
    foo = Foo.new
    foo.assign_xml_elements(
      bar: {
        baz: 42,
        qux: [1, 2, 3],
      },
      name: "John",
      description: "Test"
    )
    assert_equal XML_STRING, foo.to_xml
  end

  def test_encode_from_hash_internal
    foo = Foo.new
    foo.bar = {
      baz: 42,
      qux: [1, 2, 3],
    }
    foo.name = "John"
    foo.description = "Test"
    assert_equal XML_STRING, foo.to_xml
  end

  def test_encode_from_hash_internal_fail
    foo = Foo.new
    assert_raises ArgumentError do
      foo.bar = {
        baz: 42,
        qux: [1, 2, 3],
        bad: 42,
      }
    end
    assert_raises ArgumentError do
      foo.description = {
        bad: 42,
      }
    end
  end

  def test_encode_from_symbol
    foo = Foo.new(
      bar: {
        baz: :meters,
        qux: [2, 3, 4],
      }
    )
    assert_equal 4, foo.bar.baz
  end

  def test_encode_from_symbol_fail
    foo = Foo.new
    assert_raises KeyError do
      foo.bar = {
        baz: :pizza,
        qux: [2, 3, 4],
      }
    end
  end

  class Container < MyDATA::Schema::Element
    xml_element :items, multiple: true
  end

  class Items < MyDATA::Schema::Element
    xml_element :name, :string
    xml_element :value, :integer
  end

  def test_encode_array_of_object
    container = Container.new(
      items: [
        { name: "One", value: 1 },
        { name: "Two", value: 2 },
      ]
    )

    expected = <<~XML_STRING
      <?xml version="1.0" encoding="UTF-8"?>
      <container>
        <items>
          <name>One</name>
          <value>1</value>
        </items>
        <items>
          <name>Two</name>
          <value>2</value>
        </items>
      </container>
    XML_STRING

    assert_equal expected, container.to_xml

    container = Container.new
    container.items << { name: "One", value: 1 }
    container.items << { name: "Two", value: 2 }

    assert_equal expected, container.to_xml
  end
end
