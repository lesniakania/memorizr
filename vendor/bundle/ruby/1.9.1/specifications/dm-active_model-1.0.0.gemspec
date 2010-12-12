# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dm-active_model}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Martin Gamsjaeger (snusnu)"]
  s.date = %q{2010-06-08}
  s.description = %q{A datamapper plugin for active_model compliance and thus rails 3 compatibility.}
  s.email = %q{gamsnjaga [a] gmail [d] com}
  s.extra_rdoc_files = ["LICENSE", "README.rdoc", "TODO"]
  s.files = [".document", ".gitignore", "CHANGELOG", "Gemfile", "LICENSE", "README.rdoc", "Rakefile", "TODO", "VERSION", "dm-active_model.gemspec", "lib/dm-active_model.rb", "lib/dm-active_model/version.rb", "spec/amo_interface_compliance_spec.rb", "spec/amo_validation_compliance_spec.rb", "spec/dm-active_model_spec.rb", "spec/lib/amo_lint_extensions.rb", "spec/rcov.opts", "spec/spec.opts", "tasks/changelog.rake", "tasks/ci.rake", "tasks/local_gemfile.rake", "tasks/metrics.rake", "tasks/spec.rake", "tasks/yard.rake", "tasks/yardstick.rake"]
  s.homepage = %q{http://github.com/datamapper/dm-active_model}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{datamapper}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{active_model compliance for datamapper}
  s.test_files = ["spec/amo_interface_compliance_spec.rb", "spec/amo_validation_compliance_spec.rb", "spec/dm-active_model_spec.rb", "spec/lib/amo_lint_extensions.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dm-core>, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<activemodel>, ["~> 3.0.0.beta3"])
      s.add_development_dependency(%q<dm-validations>, ["~> 1.0.0"])
      s.add_development_dependency(%q<rspec>, ["~> 1.3"])
      s.add_development_dependency(%q<test-unit>, ["= 1.2.3"])
    else
      s.add_dependency(%q<dm-core>, ["~> 1.0.0"])
      s.add_dependency(%q<activemodel>, ["~> 3.0.0.beta3"])
      s.add_dependency(%q<dm-validations>, ["~> 1.0.0"])
      s.add_dependency(%q<rspec>, ["~> 1.3"])
      s.add_dependency(%q<test-unit>, ["= 1.2.3"])
    end
  else
    s.add_dependency(%q<dm-core>, ["~> 1.0.0"])
    s.add_dependency(%q<activemodel>, ["~> 3.0.0.beta3"])
    s.add_dependency(%q<dm-validations>, ["~> 1.0.0"])
    s.add_dependency(%q<rspec>, ["~> 1.3"])
    s.add_dependency(%q<test-unit>, ["= 1.2.3"])
  end
end
