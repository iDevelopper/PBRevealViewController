#
# Be sure to run `pod lib lint PBRevealViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'PBRevealViewController'
    s.version          = '1.3.4'
    s.summary          = 'A slide UIViewController subclass for revealing a side (left and/or right) view controller above or below a main view controller.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
A slide UIViewController subclass for revealing a side (left and/or right) view controller above or below a main view controller for iOS and tvOS.
A category method on UIViewController, `revealViewController`, to get the parent `PBRevealViewController` of any child controller, similar to the UIViewController's property `navigationController`.
DESC

    s.homepage         = 'https://github.com/iDevelopper/PBRevealViewController'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'iDevelopper' => 'patrick.bodet4@wanadoo.fr' }
    s.source           = { :git => 'https://github.com/iDevelopper/PBRevealViewController.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'
    s.tvos.deployment_target = '9.0'
    
    s.swift_version = '5.0'

    s.default_subspec = 'ObjC'

    s.subspec 'ObjC' do |ss|
        ss.ios.deployment_target = '8.0'
        ss.tvos.deployment_target = '9.0'
        ss.source_files = 'Sources/Classes/**/*.{h,m}'
    end

    s.subspec 'Swift' do |ss|
        ss.ios.deployment_target = '8.0'
        ss.tvos.deployment_target = '9.0'
        #ss.swift_version = '4.0'
        ss.source_files = 'Sources/Classes/**/*.{swift}'
    end
end
