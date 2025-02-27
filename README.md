MyDATA Invoicing
================

**MyDATA invoicing** is a Ruby gem that implements a client for the MyDATA API from [AADE](https://www.aade.gr/en). 

The Greek Public Revenue Authority (**AADE**) established **my Digital Accounting and Tax Application** (aka **MyDATA**) to collect electronic bookkeeping data from businesses across the country. This gem represents an extraction of the MyDATA functionality that is implemented by  [Lectronz: the best online marketplace for makers](https://lectronz.com). As such, the main focus of this gem has been the generation and sending of electronic invoices. 

Installation
------------

Add this line to your application's Gemfile:

```ruby
gem 'mydata-invoicing'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mydata-invoicing

Usage
-----

### Creating an invoice

```ruby
invoice = = MyDATA::Schema::Invoice.new(
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
    issue_date: "2025-01-02",
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
      amount: net_value,
    }]
  ]
)

invoice.generate_totals!
```

The call to `invoice.generate_totals!` automatically calculates and generates the invoice summary section of the invoice.

Notice that the example above uses shorthand symbols to make the code more readable and less error-prone. For example, we have `vat_category::without_vat`, which the library automatically interprets as `vat_category: 7`. The library accepts both notations. 

### Sending invoices

To use the library to send invoices, you will need to create and configure an instance of the MyDATA client class as follows:

```ruby
require 'mydata'

client = MyDATA::Client.new(
  aade_user_id: "lectronz",
  ocp_apim_subscription_key: "1aca5a81be058f1f204ae4d571313ee3",
  live_mode: false,
) 
```

Replace "lectronz" with your own AADE username, and "1aca5a81be058f1f204ae4d571313ee3" with our subscription key. Set `live_mode` to `false` to run the client in AADE's test environment, and set it to `true` in production.

Sending a single invoice is straightforward:

```ruby
transmission = client.send_invoice(invoice)

result = transmission.object.response.first

if result.status_code == "Success"
  puts "MARK: #{result.invoice_mark}"
  puts "QR URL: #{result.qr_url}"
end
```

Sending more than one invoice is also simple:

```ruby
transmission = client.send_invoices([invoice1, invoice2])

transmission.object.response.each do |response|
  # deal with the response for each transmitted invoice...
end
```

Notice the different function names here: `client.send_invoice` vs `client.send_invoices`.

### Getting all transmitted documents

```ruby
response = client.request_transmitted_docs

invoices = response.object.invoices_doc.invoice

invoices.each do |invoice|
  # Deal with each invoice...
end
```

Invoices in detail
------------------

The structure of invoices and other library elements follows the XML structure defined in the AADE MyDATA specification. The XML tag names are mapped to a Ruby variable name, using underscore and lowercase letters. For example the `<vatNumber>` tag in the MyDATA specification is called `vat_number` in the library: 

```ruby
invoice = MyDATA::Schema::Invoice.new

invoice.issuer.vat_number = "888888888"
# this is equivalent to:
invoice.issuer = { vat_number: "888888888" }
```

Elements that can appear multiple times are treated as array-like elements. For example, the `<invoiceDetails>` element is mapped to the array-like element `invoice_details`:

```ruby
invoice.invoice_details = [
  { line_number: 1, net_value: 20.00, vat_category: :without_vat, ... }
  { line_number: 2, net_value: 10.00, vat_category: :without_vat, ... } 
]

invoice.invoice_details << { line_number: 3, net_value: 15.00, vat_category: :without_vat, ... } 
```

### Validations

The library provides some limited validation of created invoices, notably checking that the correct type is applied to each element:

```ruby
invoice.issuer.vat_number = 123

invoice.valid?
 => false

invoice.validation_errors
 => [["invoice > issuer > vat_number", "Expected a String, got '123' (Integer)"]] 
```

### Constants

As noted previously, the library accepts symbols to represent common constants used by the AADE MyDATA specification.

```ruby
invoice.invoice_header = { invoice_type: :intra_community_sales_invoice }
invoice.invoice_header.invoice_type 
 => "1.2"

invoice.invoice_header = { invoice_type: "1.2" }
invoice.invoice_header.invoice_type 
 => "1.2"
```

The constants are listed in [doc/constants_table.md](doc/constants_table.md).

Each constant defined in the library can be queried for further information:

```ruby
constant = MyDATA::Constants.fetch(:intra_community_sales_invoice)

constant.value
 => "1.2"

constant.description[:el]
 => "Τιμολόγιο Πώλησης/Ενδοκοινοτικές Παραδόσεις" 
```

### Exporting to xml

All MyDATA structures generated by the library can be exported to XML.

```ruby
invoice = MyDATA::Schema::Invoice.new(
  issuer: { 
    vat_number: "88888888", 
    branch: "0", 
    country: "GR" 
  }
)

puts invoice.to_xml
<?xml version="1.0" encoding="UTF-8"?>
<invoice>
  <issuer>
    <vatNumber>88888888</vatNumber>
    <country>GR</country>
    <branch>0</branch>
  </issuer>
</invoice>
```


Development
-----------

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

When running `rake test` all API calls to MyDATA use [webmock](https://github.com/bblimke/webmock) and do not result in real calls to the AADE MyDATA API. However, it is possible to run a series of tests that call the AADE MyDATA API (in their test environment) by running `rake test:system`. Note that AADE imposes rate limits on their test environment that may occasionally cause the API calls to respond with a 429 error code. 

Running `rake test` or `rake test:system` requires the definition of the following environment variables `AADE_USER_ID`, `OCP_APIM_SUBSCRIPTION_KEY` and `AADE_VAT_ID`. Both `AADE_USER_ID` and `OCP_APIM_SUBSCRIPTION_KEY` are obtained when [creating an account](https://www1.aade.gr/saadeapps2/bookkeeper-web) for the AADE MyDATA test environment. 


To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Contributing
------------

Bug reports and pull requests are welcome on GitHub at https://github.com/omzlo/mydata-invoicing.

License
-------

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
