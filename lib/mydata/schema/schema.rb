# frozen_string_literal: true

module MyDATA
  # XML elements used in MyDATA
  module Schema
    class Invoice < Element
      xml_element :uid
      xml_element :mark, :integer
      xml_element :cancelledByMark
      xml_element :authenticationCode
      xml_element :issuer
      xml_element :counterpart
      xml_element :invoice_header
      xml_element :payment_methods
      xml_element :invoice_details, multiple: true
      xml_element :taxes_totals
      xml_element :invoice_summary
      xml_element :qr_code_url
      xml_element :invoice_format, :integer

      def generate_totals!
        raise ArgumentError, "Invoice details are empty" if invoice_details.empty?

        summary = InvoiceSummary.new
        summary.total_net_value = 0
        summary.total_vat_amount = 0
        summary.total_withheld_amount = 0
        summary.total_fees_amount = 0
        summary.total_stamp_duty_amount = 0
        summary.total_other_taxes_amount = 0
        summary.total_deductions_amount = 0
        summary.total_gross_value = 0
        income_class = {}
        invoice_details.each do |details|
          summary.total_net_value += details.net_value
          summary.total_vat_amount += details.vat_amount
          summary.total_gross_value += (details.net_value + details.vat_amount)

          details.income_classification.each do |ic|
            key = "#{ic.classification_type}.#{ic.classification_category}"
            if income_class.key? key
              income_class[key].amount += ic.amount
            else
              income_class[key] = ic.clone
            end
          end
        end
        summary.income_classification = []
        income_class.each_value do |val|
          summary.income_classification.push(val)
        end
        self.invoice_summary = summary
      end
    end

    class PartyType < Element
      xml_element :vat_number
      xml_element :country
      xml_element :branch, :integer
      xml_element :name
      xml_element :address
    end

    class Issuer < PartyType
    end

    class Counterpart < PartyType
    end

    class Address < Element
      xml_element :street
      xml_element :number
      xml_element :postal_code
      xml_element :city
    end

    class InvoiceHeader < Element
      xml_element :series
      xml_element :aa
      xml_element :issue_date, :date
      xml_element :invoice_type
      xml_element :vat_payment_suspension, :boolean
      xml_element :currency
      xml_element :exchange_rate, :decimal
      xml_element :correlated_invoices, :integer, multiple: true
      xml_element :self_pricing, :boolean
      xml_element :dispatch_date, :date
      xml_element :dispatch_time, :time
      xml_element :vehicle_number
      xml_element :move_purpose, :integer

      # xml_document :invoice_type
    end

    class PaymentMethods < Element
      xml_element :payment_method_details, multiple: true
    end

    class PaymentMethodDetails < Element
      xml_element :type, :integer
      xml_element :amount, :decimal
      xml_element :payment_method_info

      # xml_document :type, key: :payment_type
    end

    class InvoiceDetails < Element
      xml_element :line_number, :integer
      xml_element :quantity, :decimal
      xml_element :measurement_unit, :integer
      xml_element :invoice_detail_type, :integer
      xml_element :net_value, :decimal
      xml_element :vat_category, :integer
      xml_element :vat_amount, :decimal
      xml_element :vat_exemption_category, :integer
      xml_element :dienergia
      xml_element :discount_option, :boolean
      xml_element :withheld_amount, :decimal
      xml_element :withheld_percent_category, :integer
      xml_element :stamp_duty_amount, :decimal
      xml_element :stamp_duty_percent_category
      xml_element :fees_amount, :decimal
      xml_element :fees_percent_category, :integer
      xml_element :other_taxes_percent_category
      xml_element :other_taxes_amount, :decimal
      xml_element :deductions_amount, :decimal
      xml_element :line_comments
      xml_element :income_classification, multiple: true
      xml_element :expenses_classification, multiple: true

      # xml_document :vat_category
      # xml_document :vat_exemption_category
      # xml_document :measurement_unit
    end

    class IncomeClassification < Element
      xml_element :classification_type, namespace: 'icls'
      xml_element :classification_category, namespace: 'icls'
      xml_element :amount, :decimal, namespace: 'icls'
      xml_element :id, namespace: 'icls'

      # xml_document :classification_type, key: :income_classification_type
      # xml_document :classification_category, key: :income_classification_category
    end

    class ExpensesClassification < Element
      xml_element :classification_type, namespace: 'ecls'
      xml_element :classification_category, namespace: 'ecls'
      xml_element :amount, :decimal, namespace: 'ecls'
      xml_element :id, namespace: 'ecls'

      # xml_document :classification_type, key: :expense_classification_type
    end

    class TaxesTotals < Element
      xml_element :taxes, multiple: true
    end

    class Taxes < Element
      xml_element :tax_type, :integer
      xml_element :tax_category, :integer
      xml_element :underlying_value, :decimal
      xml_element :tax_amount, :decimal
      xml_element :id, :integer
    end

    class InvoiceSummary < Element
      xml_element :total_net_value, :decimal
      xml_element :total_vat_amount, :decimal
      xml_element :total_withheld_amount, :decimal
      xml_element :total_fees_amount, :decimal
      xml_element :total_stamp_duty_amount, :decimal
      xml_element :total_other_taxes_amount, :decimal
      xml_element :total_deductions_amount, :decimal
      xml_element :total_gross_value, :decimal
      xml_element :income_classification, multiple: true
      xml_element :expenses_classification, multiple: true
    end

    class ResponseDoc < Element
      xml_tag 'ResponseDoc'

      xml_element :response, multiple: true
    end

    class Response < Element
      xml_element :index, :integer
      xml_element :invoice_uid
      xml_element :invoice_mark, :integer
      xml_element :classififcation_mark, :integer
      xml_element :authentication_code
      xml_element :cancellation_mark
      xml_element :qr_url
      xml_element :status_code
      xml_element :errors
    end

    class Errors < Element
      xml_element :error, multiple: true
    end

    class Error < Element
      xml_element :message
      xml_element :code
    end

    class RequestedDoc < Element
      xml_tag 'RequestedDoc'

      xml_element :invoices_doc
      xml_element :cancelled_invoices_doc
    end

    class InvoicesDoc < Element
      xml_tag 'InvoicesDoc'

      xml_schema "http://www.aade.gr/myDATA/invoice/v1.0",
        icls: "https://www.aade.gr/myDATA/incomeClassificaton/v1.0",
        ecls: "https://www.aade.gr/myDATA/expensesClassificaton/v1.0"

      xml_element :invoice, multiple: true
    end

    class CancelledInvoicesDoc < Element
      xml_element :cancelled_invoice, multiple: true
    end

    class CancelledInvoice < Element
      xml_element :invoice_mark
      xml_element :cancellation_mark
      xml_element :cancellation_date
    end
  end
end
