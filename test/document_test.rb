# frozen_string_literal: true

require "test_helper"

class DocumentTest < Minitest::Test
  def test_factory_create_local_B2B_product_invoice
    invoice = Factory.create_local_B2B_product_invoice
    assert invoice
    assert invoice.is_a?(MyDATA::Schema::Invoice)

    xml_invoice = invoice.to_xml
    assert xml_invoice
    decoded_invoice = MyDATA::Schema::Element.load_from_xml(xml_invoice, as: MyDATA::Schema::Invoice)
    assert decoded_invoice

    assert_equal invoice.invoice_header.series, decoded_invoice.invoice_header.series
  end

  def test_build_html
    invoice = Factory.create_local_B2C_product_invoice
    assert invoice
    html = invoice.to_html
    assert html
  end

  def test_build_xml
    invoice = Factory.create_local_B2C_product_invoice
    xml_invoice = invoice.to_xml
    xml = Nokogiri::XML(xml_invoice)
    assert_equal Factory.series, xml.at_css("invoiceHeader > series").text
  end

  def test_build_custom_xml
    invoice = Factory.create_local_B2C_product_invoice(
      invoice_header: {
        series: "FOOBAR",
      },
    )
    xml_invoice = invoice.to_xml
    xml = Nokogiri::XML(xml_invoice)
    assert_equal "FOOBAR", xml.at_css("invoiceHeader > series").text
  end

  def test_read_from_xml
    xml = File.read("test/support/aade-elements-requested_doc.xml")
    doc = MyDATA::Schema::Element.load_from_xml(xml, as: MyDATA::Schema::RequestedDoc)
    assert doc
    assert doc.is_a?(MyDATA::Schema::RequestedDoc)
    assert_equal 12, doc.invoices_doc.invoice.size

    invoice = doc.invoices_doc.invoice[2]

    assert_equal 400000000000006, invoice.mark
    assert_equal "53A8563E981C0DC22D01548D2AF2321F6C865C41", invoice.uid
    assert_equal "801234567", invoice.issuer.vat_number
    assert_equal "11.1", invoice.invoice_header.invoice_type
    assert_equal "3", invoice.invoice_header.aa
    assert_equal 2, invoice.invoice_details.size
    assert_equal "E3_561_006", invoice.invoice_details[0].income_classification[0].classification_type
  end

  def test_read_from_aade_example_files
    Dir["test/support/aade-[0-9][0-9]-*.xml"].each do |file|
      # puts "Reading #{file}"
      xml = File.read(file)
      decoder = MyDATA::Schema::Encoding::XMLDecoder.new(xml)
      doc = decoder.decode(MyDATA::Schema::InvoicesDoc)
      assert_empty decoder.errors
      assert doc, "Failed to parse #{file}"

      assert_xml_equivalent xml, doc.to_xml
    end
  end

  def assert_xml_equivalent(xml1, xml2)
    diff = xml_diff(xml1, xml2)
    assert diff==nil, diff
  end

  def xml_diff(xml1, xml2)
    doc1 = Nokogiri::XML(xml1)
    doc2 = Nokogiri::XML(xml2)
    xml_diff_node(doc1.root, doc2.root)
  end

  def xml_diff_node(node1, node2)
    if node1.name != node2.name
      return "Different names: #{node1.name} != #{node2.name} at #{node1.path}, on #{node1.line}"
    end
    if node1.element_children.size != node2.element_children.size
      return "Different children size: #{node1.element_children.size} != #{node2.element_children.size}, at #{node1.path}, on #{node1.line}"
    end
    if node1.element_children.size == 0
      if node1.text != node2.text
        return "Different text: #{node1.text} != #{node2.text}, at #{node1.path}, on line #{node1.line}"
      end
    else
      node1.element_children.each_with_index do |child, index|
        if diff = xml_diff_node(child, node2.element_children[index])
          return diff
        end
      end
    end
    nil
  end
end
