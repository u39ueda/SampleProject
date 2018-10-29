//
//  TitleTextFieldView.swift
//  Component
//
//  Created by 植田裕作 on 2018/10/27.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import UIKit

@IBDesignable
public class TitleTextFieldView: UIView {

    // MARK: - IBOutlet

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var textField: UITextField?

    // MARK: Properties

    // MARK: - Life cycle

    /// コードから生成された場合のコンストラクタ.
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    /// xibやstoryboardから生成された場合のコンストラクタ.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    /// <クラス名>.xibからビューを読み込む.
    private func loadFromNib() {
        Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        contentView.frame = self.bounds
        addSubview(contentView)
    }

    /// xibやstoryboardで生成された場合にサブビューやプロパティが初期化された後に呼ばれる.
    public override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: Override

    // MARK: Methods

    /// タイトルラベルに表示するテキスト.
    @IBInspectable
    public var title: String {
        get { return titleLabel?.text ?? "" }
        set { titleLabel?.text = newValue }
    }

    /// 入力フィールドに表示するテキスト.
    @IBInspectable
    public var text: String {
        get { return textField?.text ?? "" }
        set { textField?.text = newValue }
    }

    /// 入力フィールドが空の場合に表示するテキスト.
    @IBInspectable
    public var placeholder: String {
        get { return textField?.placeholder ?? "" }
        set { textField?.placeholder = newValue }
    }

}
