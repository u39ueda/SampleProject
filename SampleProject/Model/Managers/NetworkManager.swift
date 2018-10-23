//
//  NetworkManager.swift
//  Model
//
//  Created by 植田裕作 on 2018/10/23.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation
import Common

// MARK: - URLRequestConvertible

extension URL: URLRequestConvertible {
    public var nm_request: URLRequest { // swiftlint:disable:this identifier_name
        return URLRequest(url: self)
    }
}

extension URLRequest: URLRequestConvertible {
    public var nm_request: URLRequest { // swiftlint:disable:this identifier_name
        return self
    }
}

extension String: URLRequestConvertible {
    public var nm_request: URLRequest { // swiftlint:disable:this identifier_name
        return URLRequest(url: URL(string: self)!)
    }
}

public struct URLRequestBuilder {
    public enum Method {
        case get
        case postFormData
        static let post = Method.postFormData
        var value: String {
            switch self {
            case .get:
                return "GET"
            case .postFormData:
                return "POST"
            }
        }
    }

    public static var defaultCachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
    public static var defaultTimeoutInterval: TimeInterval = 60.0

    public var url: URL
    public var method: Method
    public var parameters: [URLQueryItem]
    public var headers: [RequestHeader] = []
    public var cachePolicy = URLRequestBuilder.defaultCachePolicy
    public var timeoutInterval = defaultTimeoutInterval

    public init(url: URL, method: Method = .get, parameters: [URLQueryItem] = []) {
        self.url = url
        self.method = method
        self.parameters = parameters
    }

    public init?(string: String, method: Method = .get, parameters: [URLQueryItem] = []) {
        guard let url = URL(string: string) else { return nil }
        self.url = url
        self.method = method
        self.parameters = parameters
    }

    public func build() -> URLRequest {
        var comps = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: comps.url!)
        // HTTPメソッド
        request.httpMethod = method.value
        // パラメータのセット
        switch method {
        case .get:
            // GETクエリパラメータとして追加
            comps.queryItems = (comps.queryItems ?? []) + parameters
        case .postFormData:
            // POSTボディのform-dataとしてセット
            var bodyComps = comps
            bodyComps.queryItems = parameters
            request.httpBody = (bodyComps.query ?? "").data(using: .utf8)
            // ヘッダー設定
            let contentType = RequestHeader.contentType("application/x-www-form-urlencoded")
            request.addValue(contentType.value, forHTTPHeaderField: contentType.key)
            let contentLength = RequestHeader.contentLength(Int64(request.httpBody?.count ?? 0))
            request.addValue(contentLength.value, forHTTPHeaderField: contentLength.key)
        }
        // リクエストヘッダー
        headers.forEach { (header: RequestHeader) in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        // キャッシュポリシー
        request.cachePolicy = cachePolicy
        // タイムアウト時間
        request.timeoutInterval = timeoutInterval
        return request
    }
}

extension URLRequestBuilder: URLRequestConvertible {
    public var nm_request: URLRequest { // swiftlint:disable:this identifier_name
        return build()
    }
}

public enum RequestHeader: Equatable {
    case contentLength(Int64)
    case contentType(String)
    case ifModifiedSince(Date)

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd LLL yyyy HH:mm:ss zzz"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        return formatter
    }()

    public var key: String {
        switch self {
        case .contentLength: return "Content-Length"
        case .contentType: return "Content-Type"
        case .ifModifiedSince: return "If-Modified-Since"
        }
    }

    public var value: String {
        switch self {
        case let .contentLength(value): return "\(value)"
        case let .contentType(value): return value
        case let .ifModifiedSince(value): return RequestHeader.dateFormatter.string(from: value)
        }
    }
}

public class NetworkTask: NetworkTaskProtocol {
    let task: URLSessionTask

    init(_ task: URLSessionTask) {
        self.task = task
    }

    public func cancel() {
        task.cancel()
    }

    public func resume() {
        task.resume()
    }
}

public class NetworkManager: NetworkManagerProtocol {

    // MARK: Properties

    private let proxy = URLSessionProxy()
    private let session: URLSession

    public static let `default`: NetworkManager = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.timeoutIntervalForRequest = 10.0
        config.timeoutIntervalForResource = 10.0
        return NetworkManager(config: config)
    }()

    // MARK: - Life cycle

    public required init(config: URLSessionConfiguration) {
        session = URLSession(configuration: config, delegate: proxy, delegateQueue: OperationQueue())
    }

    public func request(_ req: URLRequestConvertible, autostart: Bool, completion: @escaping CompletionHandler) -> NetworkTaskProtocol {
        let dataTask = session.dataTask(with: req.nm_request) { (data, response, error) in
            let result: Result<ValueType, Error>
            if let error = error {
                result = .failure(error)
            } else if let response = response as? HTTPURLResponse, let data = data {
                result = .success((data, response))
            } else {
                fatalError("response or data is nil.")
            }
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        let netTask = NetworkTask(dataTask)
        if autostart {
            dataTask.resume()
        }
        return netTask
    }
}

class URLSessionProxy: NSObject, URLSessionDelegate {
}
