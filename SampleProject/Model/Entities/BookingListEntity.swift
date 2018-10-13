//
//  BookingListEntity.swift
//  Model
//
//  Created by 植田裕作 on 2018/10/13.
//  Copyright © 2018年 Yusaku Ueda. All rights reserved.
//

import Foundation

/// 予約情報一覧のエンティティ
public struct BookingListEntity {
    /// 予約情報一覧
    public var bookings = [BookingEntity]()

    /// コンストラクタ
    public init() {
    }

    /// コンストラクタ
    public init(bookings: [BookingEntity]) {
        self.bookings = bookings
    }
}

/// 1件の予約情報のエンティティ
public struct BookingEntity {
}
