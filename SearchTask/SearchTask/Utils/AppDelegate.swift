//
//  AppDelegate.swift
//  SearchTask
//
//  Created by Melike Büşra Ayhan on 9.01.2021.


import UIKit
import IQKeyboardManagerSwift

class DefaultNavigation : UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
             
        return .lightContent
    }
    
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("uuid",UUID().uuidString)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController =  DefaultNavigation(rootViewController:Launch())
        
        return true
    }


}

