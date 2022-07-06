#import "FlutterSystemRingtonesPlugin.h"
#if __has_include(<flutter_system_ringtones/flutter_system_ringtones-Swift.h>)
#import <flutter_system_ringtones/flutter_system_ringtones-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_system_ringtones-Swift.h"
#endif

@implementation FlutterSystemRingtonesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSystemRingtonesPlugin registerWithRegistrar:registrar];
}
@end
