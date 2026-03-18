import SwiftUI
import Flutter

struct FlutterViewControllerRepresentable: UIViewControllerRepresentable {
  @Environment(FlutterDependencies.self) var flutterDependencies

  func makeUIViewController(context: Context) -> some UIViewController {
    return FlutterViewController(
      engine: flutterDependencies.flutterEngine,
      nibName: nil,
      bundle: nil)
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct ContentView: View {
    var body: some View {
        FlutterViewControllerRepresentable()
            .ignoresSafeArea()
    }
}
