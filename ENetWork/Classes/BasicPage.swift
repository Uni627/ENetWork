//
//  BasicPage.swift
//  EServices
//
//  Created by pxy on 2020/2/15.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation

public struct BasicPage {
    public var pageNum: String = "1"
    public var pageSize: String = "20"

    public init(page: String = "1", pageSize: String = "20") {
        self.pageNum = page
        self.pageSize = pageSize
    }

    public func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary["pageNum"] = pageNum
        dictionary["pageSize"] = pageSize
        return dictionary
    }
}
