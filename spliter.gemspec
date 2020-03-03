Gem::Specification.new do |s|
    s.name = %q{spliter}
    s.version = "1.0.0"
    s.date = %q{2020-03-03}
    s.summary = %q{spliter for siteops proccess}
    s.files = [
      "lib/spliter.rb",
      "bin/spliter"
    ]
    s.require_paths = ["lib", "bin"]
    s.executables << 'spliter'
    s.authors = "Henrique do OPS"
    s.requirements << 'roo'
    s.requirements << 'write_xlsx'
    s.requirements << 'rubyXL'
  end