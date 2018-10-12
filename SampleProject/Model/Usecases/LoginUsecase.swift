//
//  LoginUsecase.swift
//  SampleProject
//
//  Created by 植田裕作 on 2018/10/12.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginUsecase: LoginUsecaseProtocol {

    // MARK: Properties

    // MARK: - Life cycle

    /// コンストラクタ
    init() {
    }

    /// ログイン処理
    /// ログインして得た認証情報等はリポジトリから直接取得する.
    ///
    /// - Parameters:
    ///   - memberId: 会員ID
    ///   - password: パスワード
    /// - Returns: 完了の通知
    func login(memberId: String, password: String) -> Single<Void> {
        return Observable.create({ (observer) -> Disposable in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                observer.onCompleted()
            })
            return Disposables.create()
        }).asSingle()
    }
}
