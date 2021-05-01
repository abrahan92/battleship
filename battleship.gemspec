# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "battleship/version"

Gem::Specification.new do |gem|
  gem.name          = "battleship"
  gem.version       = Battleship::VERSION
  gem.authors       = ["Abrahan Mendoza"]
  gem.email         = ["mendozaabrahan@gmail.com"]
  gem.description   = "A command line version of battleship game"
  gem.summary       = "Play battleship for 2 players"
  gem.homepage      = "https://github.com/StuartHiring/ruby-test-abrahan92"
  gem.license       = "Abrahan"

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = "~> 2.6.1"

  gem.add_development_dependency "bundler", "~> 2.2.16"
  gem.add_development_dependency "colorize"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rubocop"
  gem.add_development_dependency "rubocop-rspec"
end
