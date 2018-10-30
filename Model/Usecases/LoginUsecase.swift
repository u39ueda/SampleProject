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
    public var userDefaults: UserDefaultsManagerProtocol?

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
        // ユーザ情報取得APIのダミー呼び出し
        func callUserInformation() -> Single<UserInformationEntity> {
            return Single.create { (observer) -> Disposable in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    let userInfo = UserInformationEntity(lastName: "太郎", firstName: "山田", token: "0123456789ABCDEF", fetchDate: Date())
                    observer(.success(userInfo))
                }
                return Disposables.create()
            }
        }
        return callUserInformation()
            .do(onSuccess: { (userInformation: UserInformationEntity) in
                self.userDefaults?.credential = CredentialEntity(memberId: memberId, password: password, token: userInformation.token, lastTokenRefreshDate: userInformation.fetchDate)
            })
            .map({ _ in return () })
    }
}
