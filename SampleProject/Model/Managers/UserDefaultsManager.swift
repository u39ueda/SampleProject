//
//  UserDefaultsManager.swift
//  Model
//
//  Created by 植田裕作 on 2018/10/30.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation
import Common
import RxSwift
import RxCocoa

public final class UserDefaultsManager: UserDefaultsManagerProtocol {

    private enum Keys: String {
        case credential
    }

    /// メモリ上で保持するだけのストレージ
    ///
    /// 後から永続化できるようにCodableを適用したオブジェクトのみ保持するようにしている.
    private var memoryStore = [Keys: Codable]()

    // MARK: 認証データ

    /// ストリーム本体
    private lazy var credentialRelay = BehaviorRelay(value: credential)
    /// 認証データの購読用ストリーム
    public var credentialValue: Observable<CredentialEntity> {
        return credentialRelay.asObservable()
    }
    /// 認証データ
    public var credential: CredentialEntity {
        get { return getFromMemory(.credential) ?? CredentialEntity() }
        set { setToMemory(newValue, forKey: .credential, toRelay: credentialRelay) }
    }

}

extension UserDefaultsManager {
    /// シングルトンオブジェクト
    public static let shared = UserDefaultsManager()
}

extension UserDefaultsManager {

    // MARK: Memory

    /// メモリ上に保存されている値を取得する.
    ///
    /// - Parameter key: 取得するオブジェクトのキー名.
    /// - Returns: 保存されている値.
    private func getFromMemory<T>(_ key: Keys) -> T? where T: Codable {
        precondition(memoryStore[key] is T, "型'\(type(of: memoryStore[key]))'は型'\(T.self)'へ変換できませんでした.")
        return memoryStore[key] as? T
    }

    /// 指定した値をメモリ上に保存する.
    ///
    /// - Parameters:
    ///   - newValue: 保存する値.
    ///   - key: 保存する時のキー名.
    ///   - relay: 保存時に通知するストリーム.
    private func setToMemory<T>(_ newValue: T, forKey key: Keys, toRelay relay: BehaviorRelay<T>) where T: Codable {
        memoryStore[key] = newValue
        relay.accept(newValue)
    }

    /// 指定した値をメモリ上に保存する.
    ///
    /// 値にnilを指定するとメモリ上から削除する.
    /// - Parameters:
    ///   - newValue: 保存する値.
    ///   - key: 保存する時のキー名.
    ///   - relay: 保存時に通知するストリーム.
    private func setToMemory<T>(_ newValue: T?, forKey key: Keys, toRelay relay: BehaviorRelay<T?>) where T: Codable {
        memoryStore[key] = newValue
        relay.accept(newValue)
    }

    /// メモリ上に保存されている値を削除する.
    ///
    /// このメソッドで削除した値はRelayに送信されない.
    /// - Parameter key: 削除するオブジェクトのキー名.
    private func removeFromMemory(_ key: Keys) {
        memoryStore[key] = nil
    }

    // MARK: UserDefaults

    /// UserDefaultsに保存されているData型からT型に変換して返す.
    ///
    /// - Parameter key: 取得するオブジェクトのキー名.
    /// - Returns: 保存されている値.
    private func get<T>(_ key: Keys) -> T? where T: Decodable {
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try? decoder.decode(T.self, from: data)
    }

    /// 指定した値をUserDefaultsに保存する.
    ///
    /// - Parameters:
    ///   - newValue: 保存するT型の値.
    ///   - key: 保存する時のキー名.
    ///   - relay: 保存時に通知するストリーム.
    private func set<T>(_ newValue: T, forKey key: Keys, toRelay relay: BehaviorRelay<T>) where T: Encodable {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(newValue) else {
            log.warning("JSONEncoder().encode() falied. type=\(T.self)")
            return
        }
        log.debug("Save data[\(key.rawValue)]=\(String(data: data, encoding: .utf8) ?? "nil")")
        UserDefaults.standard.set(data, forKey: key.rawValue)
        relay.accept(newValue)
    }

    /// 指定した値をUserDefaultsに保存する.
    ///
    /// 値にnilを指定するとメモリ上から削除する.
    /// - Parameters:
    ///   - newValue: 保存する値.
    ///   - key: 保存する時のキー.
    ///   - relay: 保存時に通知するストリーム.
    private func set<T>(_ newValue: T?, forKey key: Keys, toRelay relay: BehaviorRelay<T?>?) where T: Encodable {
        guard let newValue = newValue else {
            log.debug("Save data[\(key.rawValue)]=nil")
            UserDefaults.standard.removeObject(forKey: key.rawValue)
            relay?.accept(nil)
            return
        }
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(newValue) else {
            log.warning("JSONEncoder().encode() falied. type=\(T.self)")
            return
        }
        log.debug("Save data[\(key.rawValue)]=\(String(data: data, encoding: .utf8) ?? "nil")")
        UserDefaults.standard.set(data, forKey: key.rawValue)
        relay?.accept(newValue)
    }

    /// UserDefaultsに保存されている値を削除する.
    ///
    /// このメソッドで削除した値はRelayに送信されない.
    /// - Parameter key: 削除するオブジェクトのキー.
    private func remove(_ key: Keys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
