# frozen_string_literal: true

require "test_helper"

class ConstantsTest < Minitest::Test
  def test_success_validate
    assert_equal "1.1", MyDATA::Constants.validate_value!("1.1", category: :invoice_type)
    assert_equal 4, MyDATA::Constants.validate_value!(4, category: :measurement_unit)

    assert_equal "1.1", MyDATA::Constants.validate!(:sales_invoice, category: :invoice_type)
    assert_equal 4, MyDATA::Constants.validate!(:meters, category: :measurement_unit)

    assert_equal "1.1", MyDATA::Constants.validate!(:sales_invoice)
    assert_equal 4, MyDATA::Constants.validate!(:meters)
  end

  def test_fail_validate
    assert_raises(KeyError) do
      MyDATA::Constants.validate_value!("foobar", category: :invoice_type)
    end
    assert_raises(KeyError) do
      MyDATA::Constants.validate_value!(99, category: :measurement_unit)
    end
    assert_raises(KeyError) do
      MyDATA::Constants.validate!(:potatoes, category: :measurement_unit)
    end
    assert_raises(KeyError) do
      MyDATA::Constants.validate!(:pizza)
    end
  end

  def test_success_lookup_by_value
    constant = MyDATA::Constants.lookup_by_value("1.1", category: :invoice_type)
    assert constant
    assert_equal "1.1", constant.value
    assert_equal "Sales Invoice", constant.to_s
    assert_equal "Τιμολόγιο Πώλησης", constant.to_s(:el)
    assert_equal :invoice_type, constant.category

    constant = MyDATA::Constants.lookup_by_value(4, category: :measurement_unit)
    assert constant
    assert_equal 4, constant.value
    assert_equal "meters", constant.to_s
    assert_equal "Μέτρα", constant.to_s(:el)
    assert_equal :measurement_unit, constant.category
  end

  def tess_lookup_by_description
    constant = MyDATA::Constants.lookup_by_description("Sales Invoice", category: :invoice_type)
    assert constant
    assert_equal "1.1", constant.value

    constant = MyDATA::Constants.lookup_by_description("Τιμολόγιο Πώλησης", category: :invoice_type)
    assert constant
    assert_equal "1.1", constant.value
  end

  def test_success_fetch
    constant = MyDATA::Constants.fetch(:sales_invoice)
    assert_equal "1.1", constant.value

    constant = MyDATA::Constants.fetch(:meters)
    assert_equal 4, constant.value
  end

  def test_fail_lookup_by_value
    assert_nil MyDATA::Constants.lookup_by_value("foobar", category: :invoice_type)
  end

  def test_fail_fetch
    assert_nil MyDATA::Constants.fetch(:potatoes, category: :measurement_unit)
    assert_nil MyDATA::Constants.fetch(:pizza)
  end

  def test_success_key
    assert MyDATA::Constants.key?(:sales_invoice)
    assert MyDATA::Constants.key?(:meters)
  end

  def test_fail_describe
    refute MyDATA::Constants.key?(:pizza)
  end
end
