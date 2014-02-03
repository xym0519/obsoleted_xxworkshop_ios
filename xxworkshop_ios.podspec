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
  s.platform     = :ios
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'
  #s.resources = 'Assets'

  s.subspec 'XXLog' do |xxlog|
    xxlog.source_files = 'Classes/XXLog'
  end
  
  s.subspec 'XXGenerator' do |xxgenerator|
    xxgenerator.source_files = 'Classes/XXGenerator'
  end

  s.subspec 'XXSystem' do |xxsystem|
    xxsystem.source_files = 'Classes/XXSystem'
    xxsystem.dependency 'xxworkshop_ios/XXGenerator'
    xxsystem.dependency 'SSKeychain', '~> 1.2.1'
    xxsystem.framework = 'UIKit'
    #xxsystem.compiler_flags = '-fmodules'
  end

  s.subspec 'XXFormatter' do |xxformatter|
    xxformatter.source_files = 'Classes/XXFormatter'
    xxformatter.dependency 'SBJson', '~> 3.2'
    xxformatter.dependency 'Base64', '~> 1.0.1'
    xxformatter.dependency 'GZIP', '~> 1.0.2'
  end

  s.subspec 'XXDao' do |xxdao|
    xxdao.source_files = 'Classes/XXDao'
    xxdao.dependency 'FMDB', '~> 2.2'
    xxdao.dependency 'xxworkshop_ios/XXLog'
    xxdao.dependency 'xxworkshop_ios/XXSystem'
  end

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
end
