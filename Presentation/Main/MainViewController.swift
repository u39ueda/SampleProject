//
//  MainViewController.swift
//  SampleProject
//
//  Created by 植田裕作 on 2018/10/08.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Model
import RxSwift

final class MainViewController: UIViewController, MainViewProtocol {

    // MARK: - IBOutlet

    @IBOutlet weak var notLoginContainerView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginContainerView: UIView!
    @IBOutlet weak var fetchDateLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!

    // MARK: Properties

    private let disposeBag = DisposeBag()

	var presenter: MainPresenterProtocol?

    // MARK: - Life cycle

    init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

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

extension MainViewController {
    /// ビューと値をバインドする
    private func bindViews() {
        // ログイン済みフラグを画面に割り当てる
        presenter?.isLoginValue
            .subscribe(onNext: { [weak self] (isLogin: Bool) in
                self?.notLoginContainerView.isHidden = isLogin
                self?.loginContainerView.isHidden = !isLogin
            })
            .disposed(by: disposeBag)
        // ユーザ情報
        presenter?.userInformationValue
            .subscribe(onNext: { [weak self] (userInformation) in
                self?.userNameLabel.text = userInformation.username
                self?.fetchDateLabel.text = userInformation.fetchDateString
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions

extension MainViewController {
    @IBAction func onLoginButton(_ sender: UIButton) {
        presenter?.onLoginButton()
    }
}

// MARK: - Notifications
