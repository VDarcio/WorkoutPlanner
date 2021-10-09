//
//  AppDelegate.swift
//  WorkoutPlanner
//
//  Created by VD on 20/07/2021.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
             let realm = try Realm()
        }catch{
            print(error)
        }
        return true
    }

   
}

