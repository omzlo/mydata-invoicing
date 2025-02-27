module Factory
  @@aa = 0
  @@series = "TEST-#{Time.now.to_i.to_s(16)}"

  def self.series
    @@series
  end

  def self.create(type, **args)
    self.send "create_#{type.to_s}", **args
  end

  # ------------------
  # PRODUCT INVOICES
  # ------------------

  def self.create_local_B2C_product_invoice(line_count: 3, **args)
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      invoice_header: {
        series: @@series,
        aa: @@aa,
        issue_date: Date.today.to_s,
        invoice_type: :retail_sales_receipt,
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }],
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)
    line_count.times do |i|
      net_value = 5.10 + i
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :regular_vat_rate,
        vat_amount: (net_value*0.24).round(2),
        quantity: 1,
        measurement_unit: :pieces,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Retail Sales of Goods and Services – Private Clientele",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Product Sale Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        }],
      }
    end
    invoice.generate_totals!
    invoice
  end

  def self.create_local_B2B_product_invoice(line_count: 3, **args)
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0
      },
      counterpart: {
        vat_number: "094222211",
        country: "GR",
        branch: 0,
        address: {
          city: "IRAKLIO",
          postal_code: "22222"
        }
      },
      invoice_header: {
        invoice_type: :sales_invoice,
        series: @@series,
        aa: @@aa,
        issue_date: Date.today,
        currency: "EUR"
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0
        }]
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    line_count.times do |i|
      net_value = 5.10 + i
      vat_amount = (net_value*0.24).round(2)
      # main items
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :regular_vat_rate,
        vat_amount: vat_amount,
        quantity: 1,
        measurement_unit: :pieces,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Wholesale Sales of Goods and Services – for Traders",
            category: :income_classification_type,
          ).value,
         classification_category: MyDATA::Constants.lookup_by_description(
           "Product Sale Income",
           category: :income_classification_category,
         ).value,
         amount: net_value,
        }],
      }
    end

    ## Add shipping costs of 9.99
    net_value = 9.99
    vat_amount = (net_value*0.24).round(2)
    invoice.invoice_details << {
      line_number: line_count+1,
      net_value: net_value,
      vat_category: :regular_vat_rate,
      vat_amount: vat_amount,
      quantity: 1,
      income_classification: [{
        classification_type: MyDATA::Constants.lookup_by_description(
          "Wholesale Sales of Goods and Services – for Traders",
          category: :income_classification_type,
        ).value,
        classification_category: MyDATA::Constants.lookup_by_description(
          "Product Sale Income",
          category: :income_classification_category,
        ).value,
        amount: net_value,
      }],
    }
    invoice.generate_totals!
    invoice
  end

  def self.create_intracommunity_B2B_product_invoice(line_count: 3, **args)
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      counterpart: {
        vat_number: "12345678901",
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
        series: @@series,
        aa: @@aa,
        issue_date: Date.today.to_s,
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }]
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    line_count.times do |i|
      net_value = 5.10 + i
      # main items
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :without_vat,
        vat_amount: 0,
        vat_exemption_category: :without_vat_article_28,
        quantity: 1,
        measurement_unit: :pieces,
        income_classification: {
          classification_type: MyDATA::Constants.lookup_by_description(
            "Intra-Community Foreign Sales of Goods and Services",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Product Sale Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        },
      }
    end

    ## Add shipping costs of 9.99
    net_value = 9.99
    invoice.invoice_details << {
      line_number: line_count+1,
      net_value: net_value,
      vat_category: :without_vat,
      vat_amount: 0,
      vat_exemption_category: :without_vat_article_28,
      quantity: 1,
      income_classification: [{
        classification_type: MyDATA::Constants.lookup_by_description(
          "Intra-Community Foreign Sales of Goods and Services",
          category: :income_classification_type,
        ).value,
        classification_category: MyDATA::Constants.lookup_by_description(
          "Product Sale Income",
          category: :income_classification_category,
        ).value,
        amount: net_value,
      }],
    }
    invoice.generate_totals!
    invoice
  end


  def self.create_intracommunity_B2C_product_invoice(line_count: 3, **args)
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      invoice_header: {
        invoice_type: :retail_sales_receipt,
        series: @@series,
        aa: @@aa,
        issue_date: Date.today.to_s,
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }]
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    line_count.times do |i|
      net_value = 5.10 + i
      vat_amount = (net_value*0.20).round(2)
      # main items
      invoice.invoice_details << {
        line_number: i*2+1,
        net_value: net_value,
        vat_category: :without_vat,
        vat_amount: 0,
        vat_exemption_category: :without_vat_article_13,
        quantity: 1,
        measurement_unit: :pieces,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Retail Sales of Goods and Services – Private Clientele",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Product Sale Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        }],
      }
      # VAT for eg. France 20%
      invoice.invoice_details << {
        line_number: i*2+2,
        net_value: vat_amount,
        vat_category: :without_vat,
        vat_amount: 0,
        vat_exemption_category: :without_vat_article_47,
        quantity: 1,
        income_classification: [{
          classification_category: MyDATA::Constants.lookup_by_description(
            "Other Income-related Information",
            category: :income_classification_category,
          ).value,
          amount: vat_amount,
        }],
      }
    end

    ## Add shipping costs of 9.99
    net_value = 9.99
    vat_amount = (net_value*0.20).round(2)
    invoice.invoice_details << {
      line_number: line_count*2+1,
      net_value: net_value,
      vat_category: :without_vat,
      vat_amount: 0,
      vat_exemption_category: :without_vat_article_13,
      quantity: 1,
      income_classification: [{
        classification_type: MyDATA::Constants.lookup_by_description(
          "Retail Sales of Goods and Services – Private Clientele",
          category: :income_classification_type,
        ).value,
        classification_category: MyDATA::Constants.lookup_by_description(
          "Product Sale Income",
          category: :income_classification_category,
        ).value,
        amount: net_value,
      }],
    }
    # VAT for eg. France 20% on shipping
    invoice.invoice_details << {
      line_number: line_count*2+2,
      net_value: vat_amount,
      vat_category: :without_vat,
      vat_amount: 0,
      vat_exemption_category: :without_vat_article_47,
      quantity: 1,
      income_classification: [{
        classification_category: MyDATA::Constants.lookup_by_description(
          "Other Income-related Information",
          category: :income_classification_category,
        ).value,
        amount: vat_amount,
      }],
    }
    invoice.generate_totals!
    invoice
  end

  def self.create_third_country_product_invoice(line_count: 3, **args)
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      invoice_header: {
        invoice_type: :retail_sales_receipt,
        series: @@series,
        aa: @@aa,
        issue_date: Date.today.to_s,
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }]
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    line_count.times do |i|
      net_value = 5.10 + i
      # main items
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :without_vat,
        vat_amount: 0,
        vat_exemption_category: :without_vat_article_24,
        quantity: 1,
        measurement_unit: :pieces,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Third Country Foreign Sales of Goods and Services",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Product Sale Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        }],
      }
    end

    ## Add shipping costs of 9.99
    net_value = 9.99
    invoice.invoice_details << {
      line_number: line_count+1,
      net_value: net_value,
      vat_category: :without_vat,
      vat_amount: 0,
      vat_exemption_category: :without_vat_article_24,
      quantity: 1,
      income_classification: [{
        classification_type: MyDATA::Constants.lookup_by_description(
          "Third Country Foreign Sales of Goods and Services",
          category: :income_classification_type,
        ).value,
        classification_category: MyDATA::Constants.lookup_by_description(
          "Product Sale Income",
          category: :income_classification_category,
        ).value,
        amount: net_value,
      }]
    }
    invoice.generate_totals!
    invoice
  end

  # ------------------
  # SERVICE INVOICES
  # ------------------

  def self.create_intracommunity_B2B_service_invoice(line_count: 3, **args)
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      counterpart: {
        vat_number: "12345678901",
        country: "FR",
        branch: 0,
        name: "Test Company",
        address: {
          city: "PARIS",
          postal_code: "75011",
        },
      },
      invoice_header: {
        invoice_type: :intra_community_service_invoice,
        series: @@series,
        aa: @@aa,
        issue_date: Date.today.to_s,
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }]
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    line_count.times do |i|
      net_value = (i + 1) * 1.01
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :without_vat,
        vat_amount: 0,
        vat_exemption_category: :without_vat_article_14,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Intra-Community Foreign Sales of Goods and Services",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Provision of Services Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        }]
      }
    end
    invoice.generate_totals!
    invoice
  end

  def self.create_intracommunity_service_non_assciated_credit_invoice(line_count: 1, **args)
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      counterpart: {
        vat_number: "12345678901",
        country: "FR",
        branch: 0,
        name: "Test Company",
        address: {
          city: "PARIS",
          postal_code: "75011",
        },
      },
      invoice_header: {
        invoice_type: :credit_invoice_non_associated,
        series: @@series,
        aa: @@aa,
        issue_date: Date.today.to_s,
        currency: "EUR",
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    line_count.times do |i|
      net_value = (i + 1) * 1.05
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :without_vat,
        vat_amount: 0,
        vat_exemption_category: :without_vat_article_14,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Intra-Community Foreign Sales of Goods and Services",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Provision of Services Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        }]
      }
    end
    invoice.generate_totals!
    invoice
  end

  def self.create_intracommunity_service_associated_credit_invoice(marks = [], **args)
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      counterpart: {
        vat_number: "12345678901",
        country: "FR",
        branch: 0,
        name: "Test Company",
        address: {
          city: "PARIS",
          postal_code: "75011",
        },
      },
      invoice_header: {
        invoice_type: :credit_invoice_non_associated,
        series: @@series,
        aa: @@aa,
        issue_date: Date.today.to_s,
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }]
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    marks.size.times do |i|
      net_value = (i + 1) * 1.05
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :without_vat,
        vat_amount: 0,
        vat_exemption_category: :without_vat_article_14,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Intra-Community Foreign Sales of Goods and Services",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Provision of Services Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        }]
      }
    end
    invoice.generate_totals!
    invoice
  end


  def self.create_intracommunity_B2C_service_invoice(line_count: 3, **args)
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      invoice_header: {
        invoice_type: :service_rendered_receipt,
        series: @@series,
        aa: @@aa,
        issue_date: Date.today.to_s,
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }]
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    line_count.times do |i|
      net_value = (i + 1) * 1.01
      vat_amount = (net_value*0.24).round(2)
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :regular_vat_rate,
        vat_amount: vat_amount,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Retail Sales of Goods and Services – Private Clientele",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Provision of Services Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        }]
      }
    end
    invoice.generate_totals!
    invoice
  end

  def self.create_third_country_B2C_service_invoice(line_count: 3, **args)
    @@aa += 1
    header = {
      set_issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      invoice_header: {
        invoice_type: :service_rendered_receipt,
        series: @@series,
        aa: @@aa,
        issue_date: Date.today.to_s,
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }]
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    line_count.times do |i|
      net_value = (i + 1) * 1.01
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :without_vat,
        vat_amount: 0,
        vat_exemption_category: :without_vat_article_14,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Third Country Foreign Sales of Goods and Services",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Provision of Services Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        }]
      }
    end
    invoice.generate_totals!
    invoice
  end

  def self.create_third_country_B2B_service_invoice(line_count: 3, **args)
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      counterpart: {
        vat_number: "12345678901",
        country: "AU",
        branch: 0,
        name: "Test Company",
        address: {
          city: "Camberra",
          postal_code: "2600",
        },
      },
      invoice_header: {
        invoice_type: :third_country_service_invoice,
        series: @@series,
        aa: @@aa,
        issue_date: Date.today.to_s,
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }]
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    line_count.times do |i|
      net_value = (i + 1) * 1.01
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :without_vat,
        vat_amount: 0,
        vat_exemption_category: :without_vat_article_14,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Third Country Foreign Sales of Goods and Services",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Provision of Services Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        }]
      }
    end
    invoice.generate_totals!
    invoice
  end

  def self.create_local_B2B_service_invoice(line_count: 3, **args)
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      counterpart: {
        vat_number: "094222211",
        country: "GR",
        branch: 0,
        address: {
          city: "IRAKLIO",
          postal_code: "222222",
        },
      },
      invoice_header: {
        invoice_type: :service_invoice,
        series: @@series,
        aa: @@aa,
        issue_date: Date.today.to_s,
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }]
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    line_count.times do |i|
      net_value = (i + 1) * 1.01
      vat_amount = (net_value*0.24).round(2)
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :regular_vat_rate,
        vat_amount: vat_amount,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Wholesale Sales of Goods and Services – for Traders",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Provision of Services Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        }]
      }
    end
    invoice.generate_totals!
    invoice
  end

  def self.create_local_B2C_service_invoice(line_count: 3, **args)
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      invoice_header: {
        invoice_type: :service_rendered_receipt,
        series: @@series,
        aa: @@aa,
        issue_date: Date.today.to_s,
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }]
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    line_count.times do |i|
      net_value = (i + 1) * 1.01
      vat_amount = (net_value*0.24).round(2)
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :regular_vat_rate,
        vat_amount: vat_amount,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Retail Sales of Goods and Services – Private Clientele",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Provision of Services Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        }]
      }
    end
    invoice.generate_totals!
    invoice
  end

  def self.create_erroneous_invoice(line_count: 3, **args)
    # Errors:
    # - invalid VAT number
    # - 0% VAT without exemption category
    @@aa += 1
    header = {
      issuer: {
        vat_number: AADE_VAT_ID,
        country: "GR",
        branch: 0,
      },
      counterpart: {
        vat_number: "888888888",
        country: "GR",
        branch: 0,
        address: {
          city: "IRAKLIO",
          postal_code: "22222",
        },
      },
      invoice_header: {
        invoice_type: :sales_invoice,
        series: @@series,
        aa: @@aa,
        issue_date: Date.today,
        currency: "EUR",
      },
      payment_methods: {
        payment_method_details: [{
          type: :on_credit,
          amount: 0,
        }]
      }
    }
    header = self.merge_hash(header, args)
    invoice = MyDATA::Schema::Invoice.new(**header)

    line_count.times do |i|
      net_value = 5.10 + i
      vat_amount = (net_value*0.24).round(2)
      # main items
      invoice.invoice_details << {
        line_number: i+1,
        net_value: net_value,
        vat_category: :regular_vat_rate,
        vat_amount: vat_amount,
        quantity: 1,
        measurement_unit: :pieces,
        income_classification: [{
          classification_type: MyDATA::Constants.lookup_by_description(
            "Wholesale Sales of Goods and Services – for Traders",
            category: :income_classification_type,
          ).value,
          classification_category: MyDATA::Constants.lookup_by_description(
            "Product Sale Income",
            category: :income_classification_category,
          ).value,
          amount: net_value,
        }]
      }
    end
    invoice.generate_totals!
    invoice
  end

  def self.merge_hash(first, second)
    merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
    first.merge(second, &merger)
  end
end
