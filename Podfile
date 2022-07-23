# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'iOSEngineerCodeCheck' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSEngineerCodeCheck
  # RxSwiftはSPMでバグがあるのでPodsを利用
  pod 'Moya', '~> 15.0'# MoyaはRxSwift依存のためPodsを利用

  target 'iOSEngineerCodeCheckTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iOSEngineerCodeCheckUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
