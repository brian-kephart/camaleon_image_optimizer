# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'camaleon_image_optimizer/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'camaleon_image_optimizer'
  s.version     = CamaleonImageOptimizer::VERSION
  s.authors     = ['Brian Kephart']
  s.email       = ['briantkephart@gmail.com']
  s.homepage    = 'https://www.github.com/brian-kephart/camaleon_image_optimizer'
  s.summary     = 'Compress uploaded images for faster page loads and better SEO.'
  s.description = 'Compress uploaded images for faster page loads and better SEO.'
  s.license     = 'MIT'
  s.files       = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.metadata    = {
    'homepage_uri' => 'https://www.github.com/brian-kephart/camaleon_image_optimizer',
    'changelog_uri' => 'https://www.github.com/brian-kephart/camaleon_image_optimizer/blob/master/CHANGELOG.md',
    'source_code_uri' => 'https://www.github.com/brian-kephart/camaleon_image_optimizer'
  }

  s.required_ruby_version = '~> 2.4'

  s.add_dependency 'camaleon_cms', '~> 2.0'
  s.add_dependency 'image_optim', '~> 0.26'
  s.add_dependency 'image_optim_pack', '~> 0.5'

  s.add_development_dependency 'rubocop', '~> 0.56'
  s.add_development_dependency 'sqlite3', '~> 1.3.13'
end
