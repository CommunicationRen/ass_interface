$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ass_interface/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ass_interface"
  s.version     = AssInterface::VERSION
  s.authors     = ["qingyuRen"]
  s.email       = ["994800477@qq.com"]
  s.homepage    = ""
  s.summary     = "Summary of AssInterface."
  s.description = "qingyuren AssInterface."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.7"

  s.add_development_dependency "mysql2"
  s.add_dependency "grape", '~> 0.14.0'
end
