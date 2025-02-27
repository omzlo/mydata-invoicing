# frozen_string_literal: true

require_relative "mydata/version"

require 'active_support'
require 'active_support/core_ext/string/inflections.rb'

require 'nokogiri'
require 'bigdecimal'
require 'bigdecimal/util'

require 'mydata/constants'
require 'mydata/schema/element'
require 'mydata/schema/element_array_proxy'
require 'mydata/schema/type'
require 'mydata/schema/encoding/xml_decoder'
require 'mydata/schema/encoding/xml_encoder'
require 'mydata/schema/encoding/html_encoder'
require 'mydata/schema/schema'
require 'mydata/schema/validation'
require 'mydata/schema/validator'
require 'mydata/schema/validators/category_validator'
require 'mydata/api/configuration'
require 'mydata/api/request'
require 'mydata/api/response'
require 'mydata/client'

module MyDATA
  # Empty
end
