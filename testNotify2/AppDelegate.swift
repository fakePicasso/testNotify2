//
//  AppDelegate.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/5/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
//    // ************ THIS SECTION ***************//
    func replaceWindow(_ newWindow: UIWindow) {
        if let oldWindow = window {
            newWindow.frame = oldWindow.frame
            newWindow.windowLevel = oldWindow.windowLevel
            newWindow.screen = oldWindow.screen
            newWindow.isHidden = false
            window = newWindow
            oldWindow.removeFromSuperview()
        }
    }


}

