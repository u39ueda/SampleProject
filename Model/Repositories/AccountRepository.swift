//
//  AccountRepository.swift
//  SampleProject
//
//  Created by 植田裕作 on 2018/10/13.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation
import Common
import RxSwift
import RxCocoa

/// アカウント関連のデータを取得・更新するリポジトリ.
public final class AccountRepository: AccountRepositoryProtocol {

    // MARK: Properties

    /// シングルトン
    public static let shared = AccountRepository()
    /// ユーザ情報
    private let _currentUserInformation = BehaviorRelay(value: UserInformationEntity())
    /// 予約情報一覧
    private let _currentBookingList = BehaviorRelay(value: BookingListEntity())
    /// 認証情報
    private let _currentCredential = BehaviorRelay(value: CredentialEntity())

    // MARK: - Life cycle

    /// コンストラクタ
    public init() {
    }

    // MARK: - AccountRepositoryProtocol

    /// ユーザ情報
    public var currentUserInformation: Observable<UserInformationEntity> {
        return _currentUserInformation.asObservable()
    }

    /// 予約情報一覧
    public var currentBookingList: Observable<BookingListEntity> {
        return _currentBookingList.asObservable()
    }

    /// 認証情報
    public var currentCredential: Observable<CredentialEntity> {
        return _currentCredential.asObservable()
    }

    /// ユーザ情報を取得する
    ///
    /// - Parameters:
    ///   - memberId: 会員ID
    ///   - password: パスワード
    /// - Returns: 取得したユーザ情報.
    public func requestUserInformation(memberId: String, password: String) -> Single<UserInformationEntity> {
        log.verbose()
        let task = Single.create { (observer: @escaping (SingleEvent<UserInformationEntity>) -> Void) -> Disposable in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
                let entity = UserInformationEntity()
                observer(.success(entity))
            }
            return Disposables.create()
        }
        return task
            // これ以降の処理はメインスレッドで行う
            .observeOn(MainScheduler.instance)
            // 副作用を記述
            .do(onSuccess: { (userInformation: UserInformationEntity) in
                log.verbose("success. \(userInformation)")
                // ユーザ情報の更新を通知
                self._currentUserInformation.accept(userInformation)
                // 認証情報の更新を通知
                let credential = CredentialEntity(memberId: memberId, password: password, token: userInformation.token, lastTokenRefreshDate: userInformation.fetchDate)
                self._currentCredential.accept(credential)
            }, onError: { (error: Error) in
                log.verbose("failure. \(error)")
            })
    }

    /// 予約情報一覧を取得する
    ///
    /// - Parameters:
    ///   - memberId: 会員ID
    ///   - token: 認証トークン
    /// - Returns: 取得した予約情報一覧
    public func requestBookingList(memberId: String, token: String) -> Single<BookingListEntity> {
        log.verbose()
        let task = Single.create { (observer: @escaping (SingleEvent<BookingListEntity>) -> Void) -> Disposable in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
                let entity = BookingListEntity()
                observer(.success(entity))
            }
            return Disposables.create()
        }
        return task
            // これ以降の処理はメインスレッドで行う
            .observeOn(MainScheduler.instance)
            // 副作用を記述
            .do(onSuccess: { (bookingList: BookingListEntity) in
                log.verbose("success. \(bookingList)")
                // 予約情報一覧の更新を通知
                self._currentBookingList.accept(bookingList)
            }, onError: { (error: Error) in
                log.verbose("failure. \(error)")
            })
    }

    /// 認証情報を破棄する
    public func clearCredentials() {
        log.verbose()
    }
}
