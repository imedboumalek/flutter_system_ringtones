#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_system_ringtones.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_system_ringtones'
  s.version          = '1.1.0'
  s.summary          = 'Flutter plugin to list and preview system ringtones, alarms and notification sounds.'
  s.description      = <<-DESC
A Flutter plugin that lists the device's system ringtones, alarms and
notification sounds and can preview them using native audio playback.
                       DESC
  s.homepage         = 'https://github.com/imedboumalek/flutter_system_ringtones'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Imed Boumalek' => 'imedboumalek@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'flutter_system_ringtones/Sources/flutter_system_ringtones/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If this plugin ever uses required-reason APIs, update PrivacyInfo.xcprivacy
  # and uncomment this line. See
  # https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'flutter_system_ringtones_privacy' => ['flutter_system_ringtones/Sources/flutter_system_ringtones/PrivacyInfo.xcprivacy']}
end
