import Flutter
import FlutterPluginRegistrant
import Shared

class AppDelegate: FlutterAppDelegate {
    
    var flutterEngine = FlutterEngine(name: "flutter_ui_engine")

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        InitKoinKt.doInitKoin(config: nil)

        flutterEngine.run()
    
        GeneratedPluginRegistrant.register(with: flutterEngine)

        let eventChannel = FlutterEventChannel(
            name: "com.gorman.archimed/events",
            binaryMessenger: flutterEngine.binaryMessenger
        )
        eventChannel.setStreamHandler(ArchimedStreamHandler())

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

class ArchimedStreamHandler: NSObject, FlutterStreamHandler {
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        IosBluetoothStreamHandler.shared.startListening(
            onData: { (jsonString: String) in
                DispatchQueue.main.async {
                    events(jsonString)
                }
            },
            onError: { (errorString: String) in
                DispatchQueue.main.async {
                    events(FlutterError(code: "KMP_ERROR", message: errorString, details: nil))
                }
            }
        )
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        IosBluetoothStreamHandler.shared.stopListening()
        return nil
    }
}
