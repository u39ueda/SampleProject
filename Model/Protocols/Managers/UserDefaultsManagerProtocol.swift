//
//  UserDefaultsManagerProtocol.swift
//  Model
//
//  Created by 植田裕作 on 2018/10/30.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation
import RxSwift

public protocol UserDefaultsManagerProtocol: class {
    /// 認証データの購読用ストリーム
    var credentialValue: Observable<CredentialEntity> { get }
    /// 認証データ
    var credential: CredentialEntity { get set }
}
