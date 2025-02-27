# frozen_string_literal: true

require_relative "lib/mydata/version"

Gem::Specification.new do |spec|
  spec.name          = "mydata-invoicing"
  spec.version       = MyDATA::VERSION
  spec.authors       = ["omzlo"]
  spec.email         = ["alain@omzlo.com"]

  spec.summary       = "Send invoices to AADE MyData, the national Greek electronic bookkeeping system."
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.homepage = "https://github.com/omzlo/mydata-invoicing"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Gem dependencies are added here:
  spec.add_dependency "activesupport", '~> 7.1'
  spec.add_dependency "nokogiri", '~> 1.16'
  spec.add_dependency "uri"


  # Specify the development dependencies here.
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.0"
  spec.add_development_dependency "faker", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.0"
  spec.add_development_dependency "debug", ">= 1.0.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
