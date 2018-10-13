//
//  UserInformationEntity.swift
//  Model
//
//  Created by 植田裕作 on 2018/10/13.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation

/// ユーザ情報のエンティティ
public struct UserInformationEntity {
    /// 姓
    public var lastName: String?
    /// 名
    public var firstName: String?
    /// 認証トークン
    public var token: String?
    /// 取得日時
    public var fetchDate: Date?

    /// コンストラクタ
    public init() {
    }

    /// コンストラクタ
    public init(lastName: String?, firstName: String?, token: String?, fetchDate: Date?) {
        self.lastName = lastName
        self.firstName = firstName
        self.token = token
        self.fetchDate = fetchDate
    }
}
