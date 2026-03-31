import SwiftUI
import Flutter
import FlutterPluginRegistrant
import Shared

@Observable
class FlutterDependencies {
    let flutterEngine: FlutterEngine
    
    init(engine: FlutterEngine) {
        self.flutterEngine = engine
    }
}

@main
struct iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(FlutterDependencies(engine: appDelegate.flutterEngine))
        }
    }
}
