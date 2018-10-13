//
//  AccountRepository.swift
//  SampleProject
//
//  Created by 植田裕作 on 2018/10/13.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation
import RxSwift

/// アカウント関連のデータを取得・更新するリポジトリ.
public final class AccountRepository: AccountRepositoryProtocol {

    // MARK: Properties

    /// シングルトン
    public static let shared = AccountRepository()

    // MARK: - Life cycle

    /// コンストラクタ
    public init() {
    }
}
