//
//  main.swift
//  SampleProject
//
//  Created by 植田裕作 on 2018/10/08.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import UIKit

private let appDelegateClass: AnyClass = NSClassFromString("SampleProject.UnitTestsAppDelegate") ?? AppDelegate.self
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
