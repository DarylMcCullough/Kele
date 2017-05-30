 Gem::Specification.new do |s|
   s.name          = 'kele'
   s.version       = '0.0.1'
   s.date          = '2017-05-22'
   s.summary       = 'Kele API Client'
   s.description   = 'A client for the Bloc API'
   s.authors       = ['Daryl McCullough']
   s.email         = 'stevendaryl3016@yahoo..com'
   s.files         = ['lib/kele.rb']
   s.require_paths = ["lib"]
   s.homepage      =
     'http://rubygems.org/gems/kele'
   s.license       = 'MIT'
   s.add_runtime_dependency 'httparty', '~> 0.13'
   s.add_runtime_dependency 'json'
   
   s.add_development_dependency 'vcr'
   s.add_development_dependency 'webmock'
   s.add_development_dependency 'rspec', '~> 3.0'

 end