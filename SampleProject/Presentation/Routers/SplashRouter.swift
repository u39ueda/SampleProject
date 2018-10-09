//
//  SplashRouter.swift
//  SampleProject
//
//  Created by 植田裕作 on 2018/10/10.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

final class SplashRouter: SplashWireframeProtocol {

    // MARK: Properties

    private weak var viewController: SplashViewController?

    /// Factory method
    static func createModule() -> SplashViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = SplashViewController(nibName: nil, bundle: nil)
        let router = SplashRouter()
        let presenter = SplashPresenter(interface: view, router: router)

        view.presenter = presenter
        router.viewController = view

        return view
    }

    // MARK: - Life cycle

    private init() {
    }

    deinit {
    }

    // MARK: - WireframeProtocol
}
