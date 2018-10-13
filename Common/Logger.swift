//
//  Logger.swift
//  Common
//
//  Created by 植田裕作 on 2018/10/13.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation
import XCGLogger

#if DEBUG
public let log: XCGLogger = createDebugLogger()
#else
public let log: XCGLogger = createProductLogger()
#endif

/// デバッグ用ロガーを作成する
private func createDebugLogger() -> XCGLogger {
    // 出力先なしのロガーを作成
    // Create a logger object with no destinations
    let log = XCGLogger(identifier: "commonLogger", includeDefaultDestinations: false)

    // NSLogを介してシステムコンソールへ書き出すログ出力先を作成
    // Create a destination for the system console log (via NSLog)
    let systemDestination = AppleSystemLogDestination(identifier: "advancedLogger.systemDestination")

    // オプション設定
    // Optionally set some configuration options
    systemDestination.showLogIdentifier = false
    systemDestination.showFunctionName = true
    systemDestination.showThreadName = true
    systemDestination.showLevel = true
    systemDestination.showFileName = true
    systemDestination.showLineNumber = true
    systemDestination.showDate = true

    // ロガーに出力先を追加
    // Add the destination to the logger
    log.add(destination: systemDestination)

    // ログファイルのパスを作成
    let docDirUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let logDirUrl: URL = docDirUrl.appendingPathComponent("log")
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyyMMdd-HHmmss"
    let dateString: String = formatter.string(from: Date())
    let logFileUrl: URL = logDirUrl.appendingPathComponent("\(dateString).log")
    // ログディレクトリがなければ作成
    if !FileManager.default.fileExists(atPath: logDirUrl.path) {
        do {
            try FileManager.default.createDirectory(at: logDirUrl, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            log.warning("Create log directory failed. error=\(error)")
        }
    }
    // ファイルへ書き出すログ出力先を作成
    // Create a file log destination
    let fileDestination = FileDestination(writeToFile: logFileUrl.path, identifier: "commonLogger.fileDestination")

    // オプション設定
    // Optionally set some configuration options
    fileDestination.showLogIdentifier = false
    fileDestination.showFunctionName = true
    fileDestination.showThreadName = true
    fileDestination.showLevel = true
    fileDestination.showFileName = true
    fileDestination.showLineNumber = true
    fileDestination.showDate = true

    // バックグラウンドスレッドで実行させる
    // Process this destination in the background
    fileDestination.logQueue = XCGLogger.logQueue

    // ロガーに出力先を追加
    // Add the destination to the logger
    log.add(destination: fileDestination)

    // ログ出力レベルを設定
    log.outputLevel = .debug

    // バージョン情報などアプリの基本情報を開始時に出力する
    // Add basic app info, version info etc, to the start of the logs
    log.logAppDetails()

    return log
}

/// リリース用ロガーを作成する
private func createProductLogger() -> XCGLogger {
    // 出力先なしのロガーを作成
    // Create a logger object with no destinations
    let log = XCGLogger(identifier: "commonLogger", includeDefaultDestinations: false)
    return log
}
