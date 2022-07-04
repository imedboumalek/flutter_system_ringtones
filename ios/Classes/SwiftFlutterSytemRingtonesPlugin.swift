import Flutter
import UIKit

public class SwiftFlutterSytemRingtonesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_sytem_ringtones", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterSytemRingtonesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
