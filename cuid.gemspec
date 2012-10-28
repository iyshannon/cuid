# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cuid/version"

Gem::Specification.new do |s|
  s.name        = "cuid"
  s.version     = Cuid::VERSION
  s.authors     = ["Ian Shannon"]
  s.email       = ["iyshannon@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Collision-resistant ids optimized for horizontal scaling and performance}
  s.description = %q{Ruby implementation of Eric Elliot's javascript cuid}

  s.rubyforge_project = "cuid"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
