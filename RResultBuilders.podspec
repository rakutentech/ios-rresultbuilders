#
# Be sure to run `pod lib lint RResultBuilders.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'RResultBuilders'
    s.version          = '1.2.2'
    s.summary          = 'RResultBuilders is a DSL library based on @resultBuilder'
    s.description      = <<-DESC
    RResultBuilders is available for iOS 11.0 and macOS 10.11, which makes building Attributed strings, alert and actionsheet is lot more easier than before in declarative way.
    DESC

    s.homepage         = 'https://github.com/rakutentech/ios-rresultbuilders'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Pavan' => 'pavm035' }
    s.source           = { :git => 'https://github.com/rakutentech/ios-rresultbuilders.git', :tag => s.version.to_s }

    s.ios.deployment_target = '11.0'
    s.osx.deployment_target = '10.11'
    s.watchos.deployment_target = '4.0'
    s.swift_version = "5.5"
    s.source_files = ["Sources/**/*.swift"]
end
