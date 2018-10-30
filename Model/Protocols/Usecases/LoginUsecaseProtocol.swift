//
//  LoginUsecaseProtocol.swift
//  SampleProject
//
//  Created by 植田裕作 on 2018/10/13.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation
import RxSwift

/// Presenterで使う共通処理を定義する.
///
/// Usecaseに適用する.
/// Presenter -> Usecase
public protocol LoginUsecaseProtocol: class {
    /// ログイン処理
    /// ログインして得た認証情報等はリポジトリから直接取得する.
    ///
    /// - Parameters:
    ///   - memberId: 会員ID
    ///   - password: パスワード
    /// - Returns: 完了または失敗の通知
    func login(memberId: String, password: String) -> Single<Void>
}
