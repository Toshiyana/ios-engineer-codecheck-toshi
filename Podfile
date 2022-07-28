# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'iOSEngineerCodeCheck' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSEngineerCodeCheck
  # RxSwiftはSPMでバグがあるのでPodsを利用
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'Moya/RxSwift', '~> 15.0'

  target 'iOSEngineerCodeCheckTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iOSEngineerCodeCheckUITests' do
    inherit! :search_paths
    # Pods for testing
  end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end

end
