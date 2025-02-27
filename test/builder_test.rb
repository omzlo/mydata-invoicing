# frozen_string_literal: true

require "test_helper"

class BuilderTest < Minitest::Test
  def test_that_it_builds_an_element
    counterpart = MyDATA::Schema::Counterpart.new(
      vat_number: "12345678",
      address: {
        street: "Heracleous St",
        number: "123",
        postal_code: "145 64",
        city: "Kifissia"
      }
    )
    xml = counterpart.to_xml
    assert_match "12345678", xml
    assert_match "Heracleous St", xml
    assert_match "123", xml
    assert_match "145 64", xml
    assert_match "Kifissia", xml
  end

  def test_that_it_builds_from_hash
    counterpart = MyDATA::Schema::Counterpart.new(
      vat_number: "12345678",
    )
    counterpart.address = {
      street: "Heracleous St",
      number: "123",
      postal_code: "145 64",
      city: "Kifissia"
    }

    xml = counterpart.to_xml
    assert_match "12345678", xml
    assert_match "Heracleous St", xml
    assert_match "123", xml
    assert_match "145 64", xml
    assert_match "Kifissia", xml
  end
end
