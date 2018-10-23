//
//  Result.swift
//  Common
//
//  Created by 植田裕作 on 2018/10/23.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation

public enum Result<T, E> {
    case success(T)
    case failure(E)
}
