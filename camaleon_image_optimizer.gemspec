$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "camaleon_image_optimizer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "camaleon_image_optimizer"
  s.version     = CamaleonImageOptimizer::VERSION
  s.authors     = ["Brian Kephart"]
  s.email       = ["briantkephart@gmail.com"]
  s.homepage    = ""
  s.summary     = "Compress uploaded images for faster page loads and better SEO."
  s.description = "Compress uploaded images for faster page loads and better SEO."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2"
  s.add_dependency "camaleon_cms", "~> 2.0"
  s.add_dependency "image_optim_rails", "~> 0.4.1"
  s.add_dependency "image_optim_pack", "~> 0.5.0"

  s.add_development_dependency "sqlite3"
end
