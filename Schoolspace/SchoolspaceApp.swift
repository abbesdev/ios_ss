//
//  School_spaceApp.swift
//  School space
//
//  Created by Mohamed Abbes on 15/3/2023.
//

import SwiftUI
import FirebaseCore
import LocalAuthentication

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      authenticateWithFaceID()


    return true
  }
    private func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?
        
        // Check if the device supports Face ID
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Face ID to access the app" // Custom authentication message
            
            // Perform Face ID authentication
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // Face ID authentication succeeded
                        // Proceed to open the app or perform any necessary actions
                        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: SplashView())
                    } else {
                        // Face ID authentication failed
                        // Display an error message or handle the failure case
                        exit(0) // Terminate the app after authentication failure
                    }
                }
            }
        } else {
            // Face ID is not available on the device
            // Display an error message or handle the absence of Face ID
            fatalError("Face ID is not available on this device. App will be terminated.")
        }
    }
   }





@main
struct School_spaceApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
