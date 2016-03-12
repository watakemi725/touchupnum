//
//  AppDelegate.swift
//  TouchUpNum
//
//  Created by Takemi Watanuki on 2016/02/08.
//  Copyright © 2016年 Takemi Watanuki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var scoreNumNow = 0.0
    var correctNum = 0
    var comboNum = 0
    var maxComboNum = 0
    var missNum = 0
    var speedNum = 0.0
    var switchPlay = "switch"
    
    var topNum = 0
    
    var window: UIWindow?
    
    var btnPic:[UIImage]! = [UIImage(named: "en1.png")!,UIImage(named:"en2.png")!,UIImage(named:"en3.png")!,UIImage(named:"en4.png")!,UIImage(named:"en5.png")!,UIImage(named:"en6.png")!,UIImage(named:"en7.png")!,UIImage(named:"en8.png")!]
    
    func grabStoryboard() -> UIStoryboard {
        var storyboard = UIStoryboard()
        var height = UIScreen.mainScreen().bounds.size.height
        
        if height == 480 {
            storyboard = UIStoryboard(name: "Main3.5", bundle: nil)
//            iphone4,4s
        } else if height == 667 {
            storyboard = UIStoryboard(name: "Main4.7", bundle: nil)
//            iphone6,6s
        } else if height == 736 {
            storyboard = UIStoryboard(name: "Main5.5", bundle: nil)
//            iphone6Plus
        } else {
            storyboard = UIStoryboard(name: "Main", bundle: nil)
        }
        return storyboard
    }
    
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        var storyboard: UIStoryboard = self.grabStoryboard()
        if let window = window {
            window.rootViewController = storyboard.instantiateInitialViewController()! as UIViewController
        }
        
        self.window?.makeKeyAndVisible()
        
        return true
        
        
        
        return true
    }
    
 

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

