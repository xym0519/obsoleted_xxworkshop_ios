Pod::Spec.new do |s|
  s.name         = "xxworkshop_ios"
  s.version      = "0.0.1"
  s.summary      = "pack of common tools."
  s.description  = <<-DESC
                    XXLog - a log macro which can output detailed informations
                    XXSystem - device information & runtime environment
                    XXFormatter - format conversion
                    XXGenerator - generate identifier & random value
                    XXDataManagerBase - a super class encapsulated sqlite basic functions
                   DESC
  s.homepage     = "https://github.com/xym0519/xxworkshop_ios"
  s.license      = 'MIT'
  s.author       = { "Broche Xu" => "xym0519@gmail.com" }
  s.source       = { :git => "https://github.com/xym0519/xxworkshop_ios.git", :tag => "0.0.1" }
  s.platform     = :ios
  s.requires_arc = true

  s.source_files = 'Classes'

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
end
