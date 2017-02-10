# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'color_decomposition/version'

Gem::Specification.new do |spec|
  spec.name          = "color-decomposition"
  spec.version       = ColorDecomposition::VERSION
  spec.authors       = ["Jonas Bleyl"]
  spec.summary       = %q{Quadtree decomposition of images using color.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 12.0'

  spec.add_dependency "rmagick", "~> 2.16"
  spec.add_dependency 'rake', '~> 12.0'
end
