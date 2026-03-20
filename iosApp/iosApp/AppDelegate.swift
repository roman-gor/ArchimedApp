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
        
        let methodChannel = FlutterMethodChannel(
            name: "com.gorman.archimed/methods",
            binaryMessenger: flutterEngine.binaryMessenger
        )

        observeMethodChannelCommands(methodChannel)

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    fileprivate func observeMethodChannelCommands(_ methodChannel: FlutterMethodChannel) {
        methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
            case MethodChannelCommands.startScan.value:
                let scanResult = Result {
                    IosBluetoothStreamHandler.shared.startScanning()
                }
                switch scanResult {
                case .success:
                    result(nil)
                case .failure(let error):
                    result(FlutterError(code: "ERROR START SCAN", message: "Scanning was not started", details: error))
                }
            case MethodChannelCommands.stopScan.value:
                let scanResult = Result {
                    IosBluetoothStreamHandler.shared.stopScanning()
                }
                switch scanResult {
                case .success:
                    result(nil)
                case .failure(let error):
                    result(FlutterError(code: "ERROR STOP SCAN", message: "Scanning was not stopped", details: error))
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
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
