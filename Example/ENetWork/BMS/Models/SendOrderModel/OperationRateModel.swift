//
//  OperationRateModel.swift
//  EServices
//
//  Created by uni on 2020/1/14.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class OperationRateModel: NSObject {

    public var wyYestAmountRate: Double = 0.0

    public var wyBaseAmount: Double = 0.0

    public var wyYestAmount: Double = 0.0

    public var cwYestAmountRate: Double = 0.0

    public var cwBaseAmount: Double = 0.0

    public var cwYestAmount: Double = 0.0

    public var totalBaseAmount: Double = 0.0

    public var totalYestAmountRate: Double = 0.0

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        wyBaseAmount = json["wyBaseAmount"].doubleValue
        wyYestAmountRate = json["wyYestAmountRate"].doubleValue
        totalBaseAmount = json["totalBaseAmount"].doubleValue
        wyYestAmount = json["wyYestAmount"].doubleValue
        cwYestAmountRate = json["cwYestAmountRate"].doubleValue
        cwBaseAmount = json["cwBaseAmount"].doubleValue
        totalYestAmountRate = json["totalYestAmountRate"].doubleValue
        cwYestAmount = json["cwYestAmount"].doubleValue

    }
}
