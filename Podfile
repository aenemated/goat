source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '14.0'

target 'goat' do
  use_frameworks!
  inhibit_all_warnings!

  pod 'DateToolsSwift'
  pod 'PromiseKit'
  pod 'SDWebImage'

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
	# Can be removed when moving to cocoapods 1.10
	config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
  end
  installer.pods_project.targets.each do |target|
	target.build_configurations.each do |config|
	  # Inherit the deployment target defined in this Podfile instead, e.g. platform :ios, '11.0' at the top of this file
	  config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
	end
  end
end