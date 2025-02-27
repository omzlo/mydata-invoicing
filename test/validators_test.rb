# frozen_string_literal: true

require "test_helper"

class ValidatorsTest < Minitest::Test
  class FooVal < MyDATA::Schema::Element
    xml_element :unit, :integer

    validates :unit, category: :measurement_unit
  end

  def test_category_validator
    foo = FooVal.new(unit: 1)

    expected = {category: :measurement_unit}
    assert_equal expected, FooVal.xml_element_validators[:unit]
    assert foo.valid?

    foo.unit = 99
    refute foo.valid?
    assert_equal 1, foo.validation_errors.size
    assert_equal ["fooVal", "Invalid value '99' for key 'unit' for category 'measurement_unit'"],
      foo.validation_errors[0]
  end
end
