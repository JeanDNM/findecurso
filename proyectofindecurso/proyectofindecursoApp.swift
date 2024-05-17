//
//  proyectofindecursoApp.swift
//  proyectofindecurso
//
//  Created by Jeanpierre on 2/5/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
//import GoogleMobileAds
class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
  }
}
@main
struct proyectofindecursoApp: App {
    var dB: Void = FirebaseApp.configure()
    // Registramos antes que nada AppDelegate, para que primero se llame a FirebaseApp.configure()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            HolderView().environmentObject(AuthViewModel())
        }
    }
}
