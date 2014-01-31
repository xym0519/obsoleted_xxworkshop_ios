Pod::Spec.new do |s|
  s.name         = "xxworkshop_ios"
  s.version      = "0.0.1"
  s.summary      = "A short description of xxworkshop_ios."
  s.description  = <<-DESC
                    An optional longer description of xxworkshop_ios

                    * Markdown format.
                    * Don't worry about the indent, we strip it!
                   DESC
  s.homepage     = "http://EXAMPLE/NAME"
  s.screenshots  = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license      = 'MIT'
  s.author       = { "Broche Xu" => "xym0519@gmail.com" }
  s.source       = { :git => "https://github.com/xym0519/xxworkshop_ios.git", :tag => "0.0.1" }

  # s.platform     = :ios, '5.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  s.dependency 'FMDB', '~> 2.2'
  s.dependency 'SBJson', '~> 3.2'
end
