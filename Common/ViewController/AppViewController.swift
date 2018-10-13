//
//  AppViewController.swift
//  Common
//
//  Created by 植田裕作 on 2018/10/08.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import UIKit

public final class AppViewController: UIViewController {

    // MARK: Properties

    private var _currentViewController: UIViewController
    public var currentViewController: UIViewController {
        get { return _currentViewController }
        set { setCurrentViewController(newValue, animated: false) }
    }

    // MARK: - Life cycle

    public init(viewController: UIViewController) {
        _currentViewController = viewController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        _currentViewController.view.frame = view.bounds
        addChild(_currentViewController)
        view.addSubview(_currentViewController.view)
        _currentViewController.didMove(toParent: self)
    }

    // MARK: Rotate

    // MARK: Override

    // MARK: Methods

    public func setCurrentViewController(_ newViewController: UIViewController, animated: Bool) {
        guard _currentViewController != newViewController else {
            log.warning("currentViewController and newViewController is same.")
            return
        }
        let oldViewController = _currentViewController
        oldViewController.beginAppearanceTransition(false, animated: animated)
        newViewController.beginAppearanceTransition(true, animated: animated)
        oldViewController.willMove(toParent: nil)
        _currentViewController = newViewController
        newViewController.view.frame = view.bounds
        addChild(newViewController)
        view.addSubview(newViewController.view)

        let completion: (Bool) -> Void = { (finishd) in
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            newViewController.didMove(toParent: self)
            oldViewController.endAppearanceTransition()
            newViewController.endAppearanceTransition()
        }

        if animated {
            if newViewController.view.alpha >= 1.0 {
                newViewController.view.alpha = 0.0
            }
            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                oldViewController.view.alpha = 0.0
                newViewController.view.alpha = 1.0
            }, completion: completion)
        } else {
            completion(true)
        }
    }
}
