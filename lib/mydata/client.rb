# frozen_string_literal: true

module MyDATA
  class Client
    @@disable_ssl_warning = false

    def initialize(**args)
      @config = API::Configuration.new(**args)
      if @config.disable_ssl_verify && !@@disable_ssl_warning
        puts "\e[33m-- WARNING: SSL/TLS certificate verification disabled when connecting to MyData --\e[0m"
        @@disable_ssl_warning = true
      end
    end

    def request_transmitted_docs(mark=0)
      request = API::Request.new(
        @config,
        method: :get,
        command: 'RequestTransmittedDocs',
        query_params: { 'mark' => mark },
      )
      request.execute(expecting: MyDATA::Schema::RequestedDoc)
    end

    def request_transmitted_doc(mark)
      mark = mark.to_i if mark.is_a? String
      request = API::Request.new(
        @config,
        method: :get,
        command: 'RequestTransmittedDocs',
        query_params: { 'mark' => mark - 1, 'maxMark' => mark },
      )
      request.execute(expecting: MyDATA::Schema::RequestedDoc)
    end

    def send_invoices(invoices)
      unless invoices.is_a? Array
        raise ArgumentError, "Expected an array of invoices."
      end

      # Wrap the invoices in an InvoicesDoc
      invoices_doc = MyDATA::Schema::InvoicesDoc.new(invoice: invoices)

      request = API::Request.new(
        @config,
        method: :post,
        command: 'sendInvoices',
        body: invoices_doc.to_xml,
      )
      request.execute
    end

    def send_invoice(invoice)
      send_invoices([invoice])
    end

    def cancel_invoice(mark)
      request = API::Request.new(
        @config,
        method: :post,
        command: 'CancelInvoice',
        query_params: { 'mark' => mark },
      )
      request.execute
    end
  end
end
