//
//  HomeOrderNewNumberModel.swift
//  EServices
//
//  Created by uni on 2020/7/14.
//  Copyright © 2020 EinYun. All rights reserved.
//

import UIKit

public struct HomeOrderNewNumberModel {
    ///工单key
    public var alias: String?
    ///工单数
    public var number: Int = 0
    /// 警告数
    public var warnNumber: Int = 0

    init(alias: String, number: Int, warnNumber: Int ) {
        self.alias = alias
        self.number = number
        self.warnNumber = warnNumber
    }
}

