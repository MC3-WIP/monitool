# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

inhibit_all_warnings!

target 'monitool' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for monitool
  # add the Firebase pod for Google Analytics
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  # or pod ‘Firebase/AnalyticsWithoutAdIdSupport’
  # for Analytics without IDFA collection capability
  pod 'Firebase/Messaging'
  # add pods for any other desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
  pod 'Firebase/Storage'
  
  # pods for get images with URL
  pod 'SDWebImageSwiftUI'
  pod 'Introspect'

end
