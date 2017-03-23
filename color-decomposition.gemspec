# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'color_decomposition/version'

Gem::Specification.new do |spec|
  spec.name          = 'color-decomposition'
  spec.version       = ColorDecomposition::VERSION
  spec.authors       = ['Jonas Bleyl']
  spec.summary       = 'Quadtree decomposition of images by color.'
  spec.description   = %q{Create a quadtree similarity tree by decomposing images by color.}
  spec.homepage      = 'https://github.com/jonasbleyl/color-decomposition'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test)/})
  end
  spec.required_ruby_version = '~> 2.4' 
  spec.require_paths = ['lib']
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'test-unit', '~> 3.1'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_dependency 'rmagick', '~> 2.16'
end
