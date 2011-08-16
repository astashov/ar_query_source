# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ar_query_source/version"

Gem::Specification.new do |s|
  s.name        = "ar_query_source"
  s.version     = ArQuerySource::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Anton Astashov"]
  s.email       = ["anton.astashov@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Displays ActiveRecord query source line}
  s.description = %q{Puts the source line of the SQL query after the query in logs}

  s.rubyforge_project = "ar_query_source"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
