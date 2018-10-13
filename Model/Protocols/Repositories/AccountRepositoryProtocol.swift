//
//  AccountRepositoryProtocol.swift
//  SampleProject
//
//  Created by 植田裕作 on 2018/10/13.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation
import RxSwift

/// アカウント関連のデータを取得・更新するリポジトリ.
public protocol AccountRepositoryProtocol: class {
    /// ユーザ情報
    var currentUserInformation: Observable<UserInformationEntity> { get }
    /// 予約情報一覧
    var currentBookingList: Observable<BookingListEntity> { get }
    /// 認証情報
    var currentCredential: Observable<CredentialEntity> { get }

    /// ユーザ情報を取得する
    ///
    /// - Parameters:
    ///   - memberId: 会員ID
    ///   - password: パスワード
    /// - Returns: 取得したユーザ情報.
    func requestUserInformation(memberId: String, password: String) -> Single<UserInformationEntity>
    /// 予約情報一覧を取得する
    ///
    /// - Parameters:
    ///   - memberId: 会員ID
    ///   - token: 認証トークン
    /// - Returns: 取得した予約情報一覧
    func requestBookingList(memberId: String, token: String) -> Single<BookingListEntity>
    /// 認証情報を破棄する
    func clearCredentials()
}
