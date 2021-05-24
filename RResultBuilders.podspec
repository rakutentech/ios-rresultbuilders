#
# Be sure to run `pod lib lint RResultBuilders.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'RResultBuilders'
    s.version          = '1.0.0'
    s.summary          = 'RResultBuilders is DSL library written in swift which is made easy by https://github.com/apple/swift-evolution/blob/main/proposals/0289-result-builders.md'
    s.description      = <<-DESC
    RResultBuilders is available for iOS 11.0 and macOS 10.11, which makes building Attributed strings, alert and actionsheet is lot more easier than before in declarative way.
    DESC

    s.homepage         = 'https://github.com/rakutentech/ios-rresultbuilders'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Pavan' => 'pavm035' }
    s.source           = { :git => 'hhttps://github.com/rakutentech/ios-rresultbuilders', :tag => s.version.to_s }

    s.ios.deployment_target = '11.0'
    s.osx.deployment_target = '10.11'
    s.watchos.deployment_target = '4.0'
    s.swift_version = "5.4"
    s.source_files = ["Sources/**/*.swift"]
end
