//
//  UnitTestsAppDelegate.swift
//  SampleProjectTests
//
//  Created by 植田裕作 on 2018/10/08.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import UIKit

final class UnitTestsAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
    }

}
