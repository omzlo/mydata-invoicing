# frozen_string_literal: true

require "test_helper"

# This test is used to generate/validate the examples in the README.md file.
class ReadmeTest < Minitest::Test

  def test_create_simple_intracommunity_invoice
    invoice = MyDATA::Schema::Invoice.new(
      issuer: {
        vat_number: "888888888",
        country: "GR",
        branch: 0,
      },
      counterpart: {
        vat_number: "1234567890",
        country: "FR",
        branch: 0,
        name: "Test Company",
        address: {
          city: "PARIS",
          postal_code: "75011",
        },
      },
      invoice_header: {
        invoice_type: :intra_community_sales_invoice,
        series: "I",
        aa: "1",
        issue_date: Date.parse("2025-01-02"),
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }]
      },
      invoice_details: [
        line_number: 1,
        net_value: 20.00,
        vat_category: :without_vat,
        vat_amount: 0,
        vat_exemption_category: :without_vat_article_28,
        quantity: 1,
        measurement_unit: :pieces,
        income_classification: [{
          classification_type: :E3_561_005_income,
          classification_category: :category1_2,
          amount: 20.00,
        }]
      ]
    )

    invoice.generate_totals!
    assert invoice.valid?, invoice.validation_errors.join(", ")
  end

  def test_generate_constant_table
    file = File.open("doc/constants_table.md", "w")
    file.puts "# Constants Table"
    file.puts ""
    MyDATA::Constants::BY_CATEGORY.each do |category, items|
      file.puts "## #{category.to_s.titleize}"
      file.puts ""
      file.puts "| Symbol | Value | Description |"
      file.puts "| ------ | :---: |-------------|"
      items.each do |symbol, descriptor|
        file.puts "| :#{escape_md(symbol)} | **#{escape_md(descriptor[:value])}** | #{descriptor[:description][:en]}<br> _#{descriptor[:description][:el]}_ |"
      end
    end
    file.close
  end

  def escape_md(text)
    text.to_s.gsub(/([*_`])/) { "\\" + $1 }
  end
end
