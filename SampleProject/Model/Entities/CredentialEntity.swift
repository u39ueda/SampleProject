//
//  CredentialEntity.swift
//  Model
//
//  Created by 植田裕作 on 2018/10/13.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation

/// 認証情報のエンティティ
public struct CredentialEntity {
    /// 会員ID
    public var memberId: String?
    /// パスワード
    public var password: String?
    /// 認証トークン
    public var token: String?
    /// 認証トークン最終更新日時
    public var lastTokenRefreshDate: Date?

    /// コンストラクタ
    public init() {
    }

    /// コンストラクタ
    public init(memberId: String?, password: String?, token: String?, lastTokenRefreshDate: Date?) {
        self.memberId = memberId
        self.password = password
        self.token = token
        self.lastTokenRefreshDate = lastTokenRefreshDate
    }
}
