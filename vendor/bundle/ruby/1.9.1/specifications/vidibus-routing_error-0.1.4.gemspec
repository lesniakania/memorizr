# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vidibus-routing_error}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andre Pankratz"]
  s.date = %q{2010-08-17}
  s.description = %q{Catches ActionController::RoutingError and sends it to a custom method.}
  s.email = %q{andre@vidibus.com}
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = [".document", ".gitignore", "LICENSE", "README.rdoc", "Rakefile", "VERSION", "app/controllers/routing_error_controller.rb", "config/routes.rb", "lib/vidibus-routing_error.rb", "lib/vidibus/routing_error/rack.rb", "spec/spec.opts", "spec/spec_helper.rb", "vidibus-routing_error.gemspec"]
  s.homepage = %q{http://github.com/vidibus/vidibus-routing_error}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Catches ActionController::RoutingError in Rails 3.}
  s.test_files = ["spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<relevance-rcov>, [">= 0"])
      s.add_development_dependency(%q<rr>, [">= 0"])
      s.add_runtime_dependency(%q<rails>, [">= 3.0.0.rc"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<relevance-rcov>, [">= 0"])
      s.add_dependency(%q<rr>, [">= 0"])
      s.add_dependency(%q<rails>, [">= 3.0.0.rc"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<relevance-rcov>, [">= 0"])
    s.add_dependency(%q<rr>, [">= 0"])
    s.add_dependency(%q<rails>, [">= 3.0.0.rc"])
  end
end
