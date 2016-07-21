#
# Be sure to run `pod lib lint PBRevealViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PBRevealViewController'
  s.version          = '0.2.2'
  s.summary          = 'A UIViewController subclass for revealing a left and/or right view controller above a main view controller.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A UIViewController subclass for revealing a left and/or right view controller above a main view controller.
A category method on UIViewController, `revealViewController`, to get the parent `PBRevealViewController` of any child controller, similar to the UIViewController's property `navigationController`.
                       DESC

  s.homepage         = 'https://github.com/iDevelopper/PBRevealViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iDevelopper' => 'patrick.bodet4@wanadoo.fr' }
  s.source           = { :git => 'https://github.com/iDevelopper/PBRevealViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PBRevealViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PBRevealViewController' => ['PBRevealViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
