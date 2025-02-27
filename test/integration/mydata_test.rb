# frozen_string_literal: true

require "test_helper"

class MydataIntegrationTest < Minitest::Test
  def setup
    WebMock.allow_net_connect!
    @client = MyDATA::Client.new(
      aade_user_id: AADE_USER_ID,
      ocp_apim_subscription_key: OCP_APIM_SUBSCRIPTION_KEY,
      live_mode: false,
      disable_ssl_verify: true,
      log_exchange: true,
    )
  end

  def teardown
    WebMock.disable_net_connect!
  end

  def test_send_erroneous_invoice
    invoice = Factory.create_erroneous_invoice

    query = @client.send_invoice(invoice)
    refute query.success?
    assert_equal 1, query.failures.count
    first_response = query.response.response.first
    assert_equal 2, first_response.errors.error.count
    assert_equal "888888888: Invalid Greek VAT number",
      first_response.errors.error[0].message
    assert_equal "When vatCategory has value 7, element vatExemptionCategory is mandatory",
      first_response.errors.error[1].message
  end

  def test_send_local_B2C_product_invoice
    invoice = Factory.create_local_B2C_product_invoice(
      invoice_header: {
        issue_date: Date.today,
      },
    )
    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark
    qr_url = query.response.response.first.qr_url
    assert qr_url
  end

  def test_send_local_B2B_product_invoice
    invoice = Factory.create_local_B2B_product_invoice

    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark
    qr_url = query.response.response.first.qr_url
    assert qr_url
  end

  def test_send_intracommunity_B2B_product_invoice
    invoice = Factory.create_intracommunity_B2B_product_invoice

    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark
    qr_url = query.response.response.first.qr_url
    assert qr_url
  end

  def test_send_intracommunity_B2C_product_invoice
    invoice = Factory.create_intracommunity_B2C_product_invoice

    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark
    qr_url = query.response.response.first.qr_url
    assert qr_url
  end

  def test_send_third_country_product_invoice
    invoice = Factory.create_third_country_product_invoice

    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark
    qr_url = query.response.response.first.qr_url
    assert qr_url
  end

  def test_send_intracommunity_B2B_service_invoice
    invoice = Factory.create_intracommunity_B2B_service_invoice

    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark
    qr_url = query.response.response.first.qr_url
    assert qr_url
  end

  def test_send_intracommunity_B2C_service_invoice
    invoice = Factory.create_intracommunity_B2C_service_invoice

    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark
    qr_url = query.response.response.first.qr_url
    assert qr_url
  end

  def test_send_third_country_B2C_service_invoice
    invoice = Factory.create_third_country_B2C_service_invoice

    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark
    qr_url = query.response.response.first.qr_url
    assert qr_url
  end

  def test_send_third_country_B2B_service_invoice
    invoice = Factory.create_third_country_B2B_service_invoice

    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark
    qr_url = query.response.response.first.qr_url
    assert qr_url
  end

  def test_send_local_B2B_service_invoice
    invoice = Factory.create_local_B2B_service_invoice

    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark
    qr_url = query.response.response.first.qr_url
    assert qr_url
  end

  def test_send_local_B2C_service_invoice
    invoice = Factory.create_local_B2C_service_invoice

    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark
    qr_url = query.response.response.first.qr_url
    assert qr_url
  end

  def test_send_invoice_in_the_past_and_cancel_it
    invoice = Factory.create_local_B2C_product_invoice(
      invoice_header: {
        issue_date: Date.today - 14,
      },
    )
    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark

    puts "Sleeping for 3 seconds to allow the invoice to be processed"
    sleep 3

    query = @client.cancel_invoice(mark)
    assert query.success?
    assert query.response.response.first.cancellation_mark
    assert_equal "Success", query.response.response.first.status_code
  end

  def test_send_intracommunity_service_non_associated_credit_invoice
    invoice = Factory.create_intracommunity_service_non_associated_credit_invoice

    query = @client.send_invoice(invoice)
    assert query.success?
    assert query.response.response, "Unexpected response: #{query.response.to_s}"
    mark = query.response.response.first.invoice_mark
    assert mark
    qr_url = query.response.response.first.qr_url
    assert qr_url
  end

  def test_send_intracommunity_service_associated_credit_invoice
    invoice1 = Factory.create_intracommunity_B2B_service_invoice
    invoice2 = Factory.create_intracommunity_B2B_service_invoice

    response = @client.send_invoices([invoice1, invoice2])

    assert response.success?
    mark1 = response.object.response.first.invoice_mark
    assert mark1
    mark2 = response.object.response.last.invoice_mark
    assert mark2

    puts "Sleeping for 3 seconds to allow the 2 invoices to be processed"
    sleep 3

    invoice = Factory.create_intracommunity_service_associated_credit_invoice([mark1, mark2])

    response = @client.send_invoice(invoice)
    assert response.success?
    assert response.object&.response, "Unexpected response: #{response.object.to_s}"
    assert_equal 1, response.object.response.size

    result = response.object.response.first
    assert result.invoice_mark
    assert result.qr_url
  end
end
