# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','EasyLogger_version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'EasyLogger'
  s.version = EasyLogger::VERSION
  s.author      = "Sylvain Desbureaux"
  s.email       = ["sylvain@desbureaux.fr"]
  s.homepage    = ""
  s.summary     = "EasyLogger permit to filter in lines in logs"
  s.description = "EasyLogger permit to filter in lines in logs, allowing to 
view only the inputs you want based on Class or Method"
  
# Add your other files here if you make them
  s.files = %w(
bin/EasyLogger
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','EasyLogger.rdoc']
  s.rdoc_options << '--title' << 'EasyLogger' << '--main' << 'README.rdoc' << '-ri'
    
  s.rubyforge_project = "EasyLogger"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
