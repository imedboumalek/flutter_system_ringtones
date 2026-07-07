import Flutter
import UIKit

public class FlutterSystemRingtonesPlugin: NSObject, FlutterPlugin {
    private static let uiSoundsPath: String = {
        #if targetEnvironment(simulator)
        // On the simulator, absolute paths resolve against the macOS host
        // filesystem; system sounds live under the simulator runtime root.
        let root = ProcessInfo.processInfo.environment["SIMULATOR_ROOT"] ?? ""
        #else
        let root = ""
        #endif
        return root + "/System/Library/Audio/UISounds"
    }()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "flutter_system_ringtones",
            binaryMessenger: registrar.messenger()
        )
        let instance = FlutterSystemRingtonesPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getRingtones":
            result(soundsAt(FlutterSystemRingtonesPlugin.uiSoundsPath))
        case "getAlarms":
            result(alarmSounds())
        case "getNotifications":
            result(notificationSounds())
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Sound listing

    private func soundsAt(_ path: String, recursive: Bool = false) -> [[String: Any]] {
        let fm = FileManager.default
        var sounds: [[String: Any]] = []

        do {
            let files = try fm.contentsOfDirectory(atPath: path)

            for file in files.sorted() {
                let fullPath = (path as NSString).appendingPathComponent(file)
                var isDir: ObjCBool = false
                fm.fileExists(atPath: fullPath, isDirectory: &isDir)

                if isDir.boolValue {
                    if recursive {
                        sounds.append(contentsOf: soundsAt(fullPath, recursive: true))
                    }
                    continue
                }

                let ext = (file as NSString).pathExtension.lowercased()
                guard ext == "caf" || ext == "m4r" || ext == "aiff" || ext == "wav" else { continue }

                let name = (file as NSString).deletingPathExtension
                sounds.append([
                    "id": name,
                    "title": displayName(for: name),
                    "uri": URL(fileURLWithPath: fullPath).absoluteString,
                ])
            }
        } catch {
            // Directory unreadable; return whatever was collected so far.
        }

        return sounds
    }

    private func alarmSounds() -> [[String: Any]] {
        // iOS has no alarm-type API; return sounds whose names suggest alarm/timer use.
        let keywords = ["alarm", "timer", "wake", "alert", "bell", "chime"]
        let all = soundsAt(FlutterSystemRingtonesPlugin.uiSoundsPath, recursive: true)
        let filtered = all.filter { sound in
            guard let title = sound["title"] as? String else { return false }
            let lower = title.lowercased()
            return keywords.contains { lower.contains($0) }
        }
        return filtered.isEmpty ? all : filtered
    }

    private func notificationSounds() -> [[String: Any]] {
        // nano/ sub-directory holds the short notification-length sounds.
        let nanoPath = (FlutterSystemRingtonesPlugin.uiSoundsPath as NSString)
            .appendingPathComponent("nano")
        var sounds = soundsAt(FlutterSystemRingtonesPlugin.uiSoundsPath)
        sounds.append(contentsOf: soundsAt(nanoPath))
        return sounds
    }

    private func displayName(for filename: String) -> String {
        filename
            .replacingOccurrences(of: "_", with: " ")
            .replacingOccurrences(of: "-", with: " ")
            .capitalized
    }
}
