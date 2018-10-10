//
//  LoginProtocols.swift
//  SampleProject
//
//  Created by 植田裕作 on 2018/10/08.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation
import RxSwift

// MARK: - Wireframe

/// Routerが公開するメソッドを定義する.
///
/// Routerに適用する.
/// Presenter -> Wireframe
public protocol LoginWireframeProtocol: class {
}

// MARK: - Presenter

/// PresenterがViewに対して公開するメソッド・通知オブジェクトを定義する.
///
/// Presenterに適用する.
public protocol LoginPresenterProtocol: class {

    // MARK: ViewController -> Presenter

    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
    /// ログインボタン押下時
    ///
    /// - Parameters:
    ///   - memberId: 会員ID
    ///   - password: パスワード
    func onLoginButton(memberId: String, password: String)

    // MARK: Presenter -> ViewController

    /// ログインの有効フラグ
    var isLoginEnabled: Observable<Bool> { get }
    /// ローディング中フラグ
    var isLoading: Observable<Bool> { get }
}

// MARK: - View

/// ViewがPresenterに対して公開するメソッドを定義する.
///
/// ViewControllerに適用する.
/// Presenter -> ViewController
public protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }
}
