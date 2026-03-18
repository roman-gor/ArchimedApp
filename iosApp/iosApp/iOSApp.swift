import SwiftUI
import Flutter
import FlutterPluginRegistrant

@Observable
class FlutterDependencies {
 let flutterEngine = FlutterEngine(name: "my flutter engine")
 init() {
   flutterEngine.run()
   GeneratedPluginRegistrant.register(with: self.flutterEngine);
 }
}

@main
struct iOSApp: App {
    @State var flutterDependencies = FlutterDependencies()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(flutterDependencies)
        }
    }
}
