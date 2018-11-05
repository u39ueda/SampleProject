//
//  TestViewController.swift
//  SampleProject
//
//  Created by 植田裕作 on 2018/10/13.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

#if TEST_ENABLED

import UIKit
import Common

private let reuseIdentifier = "Cell"

private struct TestSection {
    var title: String
    var items: [TestItem]
}

private struct TestItem {
    var title: String
    var subtitle: String?
    /// セル選択時の処理
    var selectedBlock: ((AppViewController) -> Void)
}

/// テスト用の画面遷移ショートカット画面
public final class TestViewController: UITableViewController {

    // MARK: - IBOutlet

    // MARK: Properties

    private let sections: [TestSection] = {
        let section1 = TestSection(title: "起動", items: [
            TestItem(title: "スプラッシュ", subtitle: nil, selectedBlock: { (appVC) in
                let vc = SplashRouter.createModule()
                appVC.currentViewController = vc
            }),
            TestItem(title: "メイン", subtitle: nil, selectedBlock: { (appVC) in
                let vc = MainRouter.createModule()
                let navi = UINavigationController(rootViewController: vc)
                appVC.currentViewController = navi
            }),
            TestItem(title: "ログイン", subtitle: nil, selectedBlock: { (appVC) in
                let vc = LoginRouter.createModule()
                let navi = UINavigationController(rootViewController: vc)
                navi.viewControllers = [UIViewController(), vc]
                appVC.currentViewController = navi
            }),
            TestItem(title: "WebView", subtitle: nil, selectedBlock: { (appVC) in
                let vc = WebViewRouter.createModule(request: "https://www.google.co.jp/")
                appVC.present(vc, animated: true)
            }),
            ])
        return [section1]
    }()

    // MARK: - Life cycle

    override public func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: Rotate

    // MARK: Override

    // MARK: - UITableViewDataSource

    /// セクションの数を返す
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    /// セクション内のセルの数を返す
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    /// セルを初期化する
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let item = sections[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        return cell
    }

    /// セクションのタイトルを返す
    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    // MARK: UITableViewDelegate

    /// セルが選択された時の処理
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.row]
        let appVC = view.window?.rootViewController as! AppViewController
        item.selectedBlock(appVC)
    }
}

#endif
