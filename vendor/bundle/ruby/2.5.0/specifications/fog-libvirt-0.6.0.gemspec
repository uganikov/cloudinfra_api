# -*- encoding: utf-8 -*-
# stub: fog-libvirt 0.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "fog-libvirt".freeze
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["geemus (Wesley Beary)".freeze]
  s.date = "2019-01-31"
  s.description = "This library can be used as a module for 'fog' or as standalone libvirt provider.".freeze
  s.email = "geemus@gmail.com".freeze
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "http://github.com/fog/fog-libvirt".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Module for the 'fog' gem to support libvirt".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fog-core>.freeze, [">= 1.27.4"])
      s.add_runtime_dependency(%q<fog-json>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<fog-xml>.freeze, ["~> 0.1.1"])
      s.add_runtime_dependency(%q<ruby-libvirt>.freeze, [">= 0.7.0"])
      s.add_runtime_dependency(%q<json>.freeze, [">= 0"])
      s.add_development_dependency(%q<net-ssh>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
      s.add_development_dependency(%q<minitest-stub-const>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_development_dependency(%q<shindo>.freeze, ["~> 0.3.4"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0"])
      s.add_development_dependency(%q<mocha>.freeze, ["~> 1.1.0"])
    else
      s.add_dependency(%q<fog-core>.freeze, [">= 1.27.4"])
      s.add_dependency(%q<fog-json>.freeze, [">= 0"])
      s.add_dependency(%q<fog-xml>.freeze, ["~> 0.1.1"])
      s.add_dependency(%q<ruby-libvirt>.freeze, [">= 0.7.0"])
      s.add_dependency(%q<json>.freeze, [">= 0"])
      s.add_dependency(%q<net-ssh>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
      s.add_dependency(%q<minitest-stub-const>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_dependency(%q<shindo>.freeze, ["~> 0.3.4"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<yard>.freeze, [">= 0"])
      s.add_dependency(%q<mocha>.freeze, ["~> 1.1.0"])
    end
  else
    s.add_dependency(%q<fog-core>.freeze, [">= 1.27.4"])
    s.add_dependency(%q<fog-json>.freeze, [">= 0"])
    s.add_dependency(%q<fog-xml>.freeze, ["~> 0.1.1"])
    s.add_dependency(%q<ruby-libvirt>.freeze, [">= 0.7.0"])
    s.add_dependency(%q<json>.freeze, [">= 0"])
    s.add_dependency(%q<net-ssh>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_dependency(%q<minitest-stub-const>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<shindo>.freeze, ["~> 0.3.4"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<mocha>.freeze, ["~> 1.1.0"])
  end
end
