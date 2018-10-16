//
//  MainViewObjects.swift
//  Model
//
//  Created by 植田裕作 on 2018/10/17.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation

public struct MainUserInformationViewObject {
    public var username: String = ""
    public var fetchDateString: String = ""

    public init() {
    }

    public init(username: String, fetchDateString: String) {
        self.username = username
        self.fetchDateString = fetchDateString
    }
}
