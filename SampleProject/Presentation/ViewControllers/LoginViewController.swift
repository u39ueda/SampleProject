//
//  LoginViewController.swift
//  SampleProject
//
//  Created by 植田裕作 on 2018/10/08.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Common
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController, LoginViewProtocol {

    // MARK: - IBOutlet

    @IBOutlet weak var memberIdLabel: UILabel!
    @IBOutlet weak var memberIdTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    // MARK: Properties

    private let disposeBag = DisposeBag()

	var presenter: LoginPresenterProtocol?

    // MARK: - Life cycle

    deinit {
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        bindViews()

        presenter?.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter?.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        presenter?.viewWillDisappear(animated)
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        presenter?.viewDidDisappear(animated)
        super.viewDidDisappear(animated)
    }

    // MARK: Rotate

    // MARK: Override

    // MARK: - ViewProtocol
}

// MARK: - Methods

extension LoginViewController {
    /// 変数とビューをバインド
    private func bindViews() {
        // ログインの有効フラグをボタンの有効フラグに反映
        presenter?.isLoginEnabled
//            .do(onNext: { (isEnabled) in log.debug("isLoginEnabled=\(isEnabled)") })
            .asDriver(onErrorJustReturn: true)
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions

extension LoginViewController {
    @IBAction func onLoginButton(_ sender: UIButton) {
        let memberId: String = memberIdTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        presenter?.onLoginButton(memberId: memberId, password: password)
    }
}

// MARK: - Notifications
