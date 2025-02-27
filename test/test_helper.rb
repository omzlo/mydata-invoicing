# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "mydata"
require "./test/factories"

require "minitest/autorun"
require "minitest/reporters"
require "faker"
require 'webmock/minitest'
require 'debug'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]

AADE_USER_ID = ENV["AADE_USER_ID"]
OCP_APIM_SUBSCRIPTION_KEY = ENV["OCP_APIM_SUBSCRIPTION_KEY"]
AADE_VAT_ID = ENV["AADE_VAT_ID"]

missing = []
missing << " - AADE_USER_ID" unless AADE_USER_ID
missing << " - OCP_APIM_SUBSCRIPTION_KEY" unless OCP_APIM_SUBSCRIPTION_KEY
missing << " - AADE_VAT_ID" unless AADE_VAT_ID

if missing.any?
  puts "\e[33mThe following environment variables are required for testing:"
  puts missing.join("\n")
  puts "For more information, please refer to the README.md file.\e[0m"
  exit 1
end

def assert_xml_equivalent(xml1, xml2)
  doc1 = Nokogiri::XML(xml1)
  doc2 = Nokogiri::XML(xml2)
  diff = xml_diff(doc1.root, doc2.root)
  assert diff==nil, diff
end

def xml_diff(node1, node2)
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
      if diff = xml_diff(child, node2.element_children[index])
        return diff
      end
    end
  end
  nil
end
