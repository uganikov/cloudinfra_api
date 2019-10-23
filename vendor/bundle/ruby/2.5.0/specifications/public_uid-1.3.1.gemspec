# -*- encoding: utf-8 -*-
# stub: public_uid 1.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "public_uid".freeze
  s.version = "1.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tomas Valent".freeze]
  s.date = "2019-07-25"
  s.description = "Automatic generates public unique identifier for model".freeze
  s.email = ["equivalent@eq8.eu".freeze]
  s.homepage = "https://github.com/equivalent/public_uid".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Automatic generates public UID column".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<orm_adapter>.freeze, ["~> 0.5"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5"])
      s.add_development_dependency(%q<rr>.freeze, ["~> 1.1.2"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<activerecord>.freeze, ["~> 4.2"])
    else
      s.add_dependency(%q<orm_adapter>.freeze, ["~> 0.5"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5"])
      s.add_dependency(%q<rr>.freeze, ["~> 1.1.2"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<activerecord>.freeze, ["~> 4.2"])
    end
  else
    s.add_dependency(%q<orm_adapter>.freeze, ["~> 0.5"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5"])
    s.add_dependency(%q<rr>.freeze, ["~> 1.1.2"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<activerecord>.freeze, ["~> 4.2"])
  end
end
