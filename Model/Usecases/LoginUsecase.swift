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

public final class LoginUsecase: LoginUsecaseProtocol {

    // MARK: Properties

    public weak var accountRepository: AccountRepositoryProtocol?

    // MARK: - Life cycle

    /// コンストラクタ
    public init() {
    }

    /// ログイン処理
    /// ログインして得た認証情報等はリポジトリから直接取得する.
    ///
    /// - Parameters:
    ///   - memberId: 会員ID
    ///   - password: パスワード
    /// - Returns: 完了または失敗の通知
    public func login(memberId: String, password: String) -> Single<Void> {
        return Single.create { (observer) -> Disposable in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                observer(.success(()))
            }
            return Disposables.create()
        }
    }
}
