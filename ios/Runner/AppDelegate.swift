import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        self.setupGGMap()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func setupGGMap() {
        GMSServices.provideAPIKey("AIzaSyDncaWGU7vqcmvlBTbr8eoUqVrMhU1NPwA")
//        GMSServices.provideAPIKey("AIzaSyBQMsFy8tDjt8Fv_bc3G4--vbEd5hm-jLA")
    }
}
