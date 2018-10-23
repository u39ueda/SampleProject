//
//  NetworkManagerProtocol.swift
//  Model
//
//  Created by 植田裕作 on 2018/10/23.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation
import Common

/// ネットワーク通信を実行するマネージャクラス.
public protocol NetworkManagerProtocol: class {

    typealias ValueType = (Data, HTTPURLResponse)
    typealias CompletionHandler = (Result<ValueType, Error>) -> Void

    /// コンストラクタ
    ///
    /// - Parameter config: コンフィグ
    init(config: URLSessionConfiguration)

    /// リクエストを実行する.
    ///
    /// autostartにfalseを指定した場合は返り値のtaskに対しresume()を呼び出す必要がある.
    /// - Parameters:
    ///   - req: リクエストに変換可能なオブジェクト.
    ///   - autostart: 呼び出しが戻る前にリクエストを開始するかどうか. true: 開始する. false: 開始しない.
    ///   - completion: リクエストが完了時に呼び出されるコールバックブロック.
    /// - Returns: リクエスト処理を表すタスク.
    func request(_ req: URLRequestConvertible, autostart: Bool, completion: @escaping CompletionHandler) -> NetworkTaskProtocol
}

extension NetworkManagerProtocol {
    /// リクエストを実行する.
    ///
    /// 呼び出しが戻る前にリクエストは開始される.
    /// - Parameters:
    ///   - req: リクエストに変換可能なオブジェクト.
    ///   - completion: リクエストが完了時に呼び出されるコールバックブロック.
    /// - Returns: リクエスト処理を表すタスク.
    func request(_ req: URLRequestConvertible, completion: @escaping CompletionHandler) -> NetworkTaskProtocol {
        return request(req, autostart: true, completion: completion)
    }
}

/// 一回のネットワーク通信処理を表すタスククラス.
public protocol NetworkTaskProtocol: class {
    /// 通信処理をキャンセルする.
    func cancel()
    /// 通信処理を開始する.
    func resume()
}

/// URLRequestへ変換可能なことを表すプロトコル.
public protocol URLRequestConvertible {
    var nm_request: URLRequest { get } // swiftlint:disable:this identifier_name
}
