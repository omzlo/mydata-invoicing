# frozen_string_literal: true

require "test_helper"

class ClientTest < Minitest::Test
  def setup
    @client = MyDATA::Client.new(
      aade_user_id: AADE_USER_ID,
      ocp_apim_subscription_key: OCP_APIM_SUBSCRIPTION_KEY,
      live_mode: false,
      disable_ssl_verify: true,
      log_exchange: false,
    )

    stub_request(:get, "https://mydataapidev.aade.gr/RequestTransmittedDocs?mark=0").
      to_return(status: 200, body: File.read("test/support/request_transmitted_docs.xml"))
    @mark = 400001843920727
    stub_request(:get, "https://mydataapidev.aade.gr/RequestTransmittedDocs?mark=#{@mark-1}&maxMark=#{@mark}").
      to_return(status: 200, body: File.read("test/support/request_single_invoice.xml"))
    stub_request(:get, "https://mydataapidev.aade.gr/RequestTransmittedDocs?mark=999999999999998&maxMark=999999999999999").
      to_return(status: 200, body: File.read("test/support/empty_docs.xml"))
    stub_request(:post, "https://mydataapidev.aade.gr/sendInvoices").
      with(body: File.read("test/support/send_invoice_request_body.xml")).
      to_return(status: 200, body: File.read("test/support/send_invoice_response.xml"))
    stub_request(:post, "https://mydataapidev.aade.gr/sendInvoices").
      with(body: /<series>BAD1<\/series>/).
      to_return(status: 200, body: File.read("test/support/send_invoice_error_response.xml"))
    stub_request(:post, "https://mydataapidev.aade.gr/sendInvoices").
      with(body: File.read("test/support/send_2_invoices_request.xml")).
      to_return(status: 200, body: File.read("test/support/send_2_invoices_response.xml"))
    stub_request(:post, "https://mydataapidev.aade.gr/sendInvoices").
      with(body: File.read("test/support/send_associated_credit_invoice_request.xml")).
      to_return(status: 200, body: File.read("test/support/send_associated_credit_invoice_response.xml"))
  end

  def test_requested_docs
    response = @client.request_transmitted_docs

    refute_nil response
    assert_equal 200, response.code
    assert response.object
    invoices = response.object.invoices_doc.invoice
    assert_equal 16, invoices.size
    assert_equal 300000000000000, invoices.first.mark
    assert_equal 300000101961934, invoices.last.mark
    assert response.object.valid?, response.object.validation_errors.join(", ")
  end

  def test_requested_doc_unique
    response = @client.request_transmitted_doc(@mark)

    refute_nil response
    assert_equal 200, response.code
    assert_equal 1, response.object.invoices_doc.invoice.size
    assert_equal @mark, response.object.invoices_doc.invoice.first.mark
  end

  def test_requested_doc_with_impossible_mark
    response = @client.request_transmitted_doc(999999999999999)
    refute_nil response
    assert_equal 200, response.code
    assert_nil response.object.invoices_doc
  end

  def test_send_invoice
    invoice = Factory.create_local_B2C_product_invoice(
      issuer: {
        vat_number: "801234567",
      },
      invoice_header: {
        issue_date: "2025-02-01",
        series: "TEST",
        aa: "1",
      },
    )
    response = @client.send_invoice(invoice)
    refute_nil response
    assert_equal 200, response.code
    assert response.object.valid?, response.object.validation_errors.join(", ")
    assert_equal 1, response.object.response.size
    result = response.object.response.first
    assert_equal 1, result.index
    assert_equal 40, result.invoice_uid.size
    assert_equal 300000102788544, result.invoice_mark
    assert result.qr_url.start_with?("https://mydataapidev.aade.gr/TimologioQR/QRInfo?q=")
    assert_equal "Success", result.status_code
  end

  def test_send_bad_invoice
    # Create two bad invoices
    # - First invoice has no issuer
    # - Second invoice has an invalid vat_number
    invoices = [
      Factory.create_local_B2C_product_invoice(
        issuer: nil,
        invoice_header: {
          issue_date: "2024-03-02",
          series: "BAD1",
        },
      ),
      Factory.create_local_B2C_product_invoice(
        issuer: {
          vat_number: "888888888",
        },
        invoice_header: {
          issue_date: "2024-03-02",
          series: "BAD2",
        },
      ),
    ]
    response = @client.send_invoices(invoices)
    refute_nil response
    assert_equal 200, response.code
    assert response.object.valid?, response.object.validation_errors.join(", ")
    responses = response.object.response
    assert_equal 2, responses.size
    assert_equal 2, responses.first.errors.error.size
    assert_equal "Issuer is mandatory for this invoice type ", responses.first.errors.error.first.message
    assert_equal 2, responses.last.errors.error.size
    assert_equal "888888888: Invalid Greek VAT number", responses.last.errors.error.last.message
  end

  def test_send_associated_credit_invoice
    invoices = [
      Factory.create_intracommunity_B2B_service_invoice(
        issuer: {
          vat_number: "801234567",
        },
        invoice_header: {
          issue_date: "2025-02-01",
          series: "TEST",
          aa: "1",
        }),
      Factory.create_intracommunity_B2B_service_invoice(
        issuer: {
          vat_number: "801234567",
        },
        invoice_header: {
          issue_date: "2025-02-01",
          series: "TEST",
          aa: "2",
        }),
    ]
    # Check that the XML is correct
    invoices_doc = MyDATA::Schema::InvoicesDoc.new(invoice: invoices)
    assert_xml_equivalent File.read("test/support/send_2_invoices_request.xml"), invoices_doc.to_xml

    # Send the 2 invoices
    response = @client.send_invoices(invoices)
    refute_nil response
    assert_equal 200, response.code
    assert response.object.valid?, response.object.validation_errors.join(", ")
    responses = response.object.response
    assert_equal 2, responses.size

    mark1 = response.object.response.first.invoice_mark
    mark2 = response.object.response.last.invoice_mark

    assert_xml_equivalent File.read("test/support/send_2_invoices_response.xml"), response.object.to_xml

    # Check that the XML is correct
    credit_invoice = Factory.create_intracommunity_service_associated_credit_invoice(
      [mark1, mark2],
      issuer: {
        vat_number: "801234567",
      },
      invoice_header: {
        issue_date: "2025-02-01",
        series: "TEST",
        aa: "3",
      },
    )
    invoice_doc = MyDATA::Schema::InvoicesDoc.new(invoice: [credit_invoice])
    assert_xml_equivalent File.read("test/support/send_associated_credit_invoice_request.xml"), invoice_doc.to_xml

    # Send the credit invoice
    response = @client.send_invoice(credit_invoice)
    refute_nil response
    assert_equal 200, response.code
    assert response.object.valid?, response.object.validation_errors.join(", ")
    assert_equal 1, response.object.response.size
    result = response.object.response.first
    assert_equal 1, result.index
    assert_equal 40, result.invoice_uid.size
    assert_equal 300000103169145, result.invoice_mark
    assert result.qr_url.start_with?("https://mydataapidev.aade.gr/TimologioQR/QRInfo?q=")
    assert_xml_equivalent File.read("test/support/send_associated_credit_invoice_response.xml"), response.object.to_xml
  end
end
