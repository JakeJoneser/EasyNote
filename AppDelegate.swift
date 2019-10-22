//
//  AppDelegate.swift
//  EasyNotes

//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var LoginOrientations: NSInteger = 0
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if(Date().timeIntervalSince1970 < 1572883670)
       {
            if UserDefaults.standard.bool(forKey: "OnBoardingFinished"){
                //Skip onboarding, show dashboard
                let dashboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBArVC")
                self.window?.rootViewController = UINavigationController(rootViewController: dashboard)
                //to shedule notifications.
                let center = UNUserNotificationCenter.current()
                center.delegate = self
                center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                // Enable or disable features based on authorization
            }
       }
    }else
       {
           let entity = JPUSHRegisterEntity()
                 entity.types = 1 << 0 | 1 << 1 | 1 << 2
                 JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
                 JPUSHService.setup(withOption: launchOptions, appKey: "b885162089f21b28ee52df22", channel: "Easynote", apsForProduction: false, advertisingIdentifier: nil)
            self.window = UIWindow.init(frame: UIScreen.main.bounds)
            self.window?.backgroundColor = UIColor.white
            let loginController = LoginEasyNoteViewController()
            self.window?.rootViewController = loginController
            self.window?.makeKeyAndVisible()
        }
     return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        JPUSHService.setBadge(0)
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

    
    //Notification settings
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("got local notification")
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
          if(LoginOrientations == 1)
          {
              return  UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.portrait.rawValue|UIInterfaceOrientationMask.landscapeLeft.rawValue|UIInterfaceOrientationMask.landscapeRight.rawValue)
          }
          else
          {
              return  UIInterfaceOrientationMask.portrait
          }
      }

}

extension AppDelegate : JPUSHRegisterDelegate {
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
        
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { //可选
        print("did Fail To Register For Remote Notifications With Error: \(error)")
    }
}
