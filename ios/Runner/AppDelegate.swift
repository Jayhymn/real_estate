import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Access the API key from the environment variables
        if let googleMapsApiKey = ProcessInfo.processInfo.environment["GOOGLE_MAPS_API_KEY"] {
            GMSServices.provideAPIKey(googleMapsApiKey)
        } else {
            print("Google Maps API Key not found in environment variables.")
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
