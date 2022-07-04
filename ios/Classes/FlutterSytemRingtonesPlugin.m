#import "FlutterSytemRingtonesPlugin.h"
#if __has_include(<flutter_sytem_ringtones/flutter_sytem_ringtones-Swift.h>)
#import <flutter_sytem_ringtones/flutter_sytem_ringtones-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_sytem_ringtones-Swift.h"
#endif

@implementation FlutterSytemRingtonesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSytemRingtonesPlugin registerWithRegistrar:registrar];
}
@end
