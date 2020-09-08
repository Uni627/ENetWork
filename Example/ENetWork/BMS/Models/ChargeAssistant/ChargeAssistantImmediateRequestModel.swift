//
//  ChargeAssistantImmediateRequestModel.swift
//  EServices
//
//  Created by pxy on 2020/2/27.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssistantImmediateRequestModel: NSObject {

    public var chargeAmount: Double = 0.0
    public var chargeReceivableId: String?
    public var chargeTypeCode: String?

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        let amount = String.init(format: "%.2f", chargeAmount)
        dictionary["chargeAmount"] = NSDecimalNumber.init(string: amount)
//        dictionary["chargeAmount"] = chargeAmount.roundTo(places: 2)
        if chargeReceivableId != nil {
            dictionary["chargeReceivableId"] = chargeReceivableId
        }
        if chargeTypeCode != nil {
            dictionary["chargeTypeCode"] = chargeTypeCode
        }
        return dictionary
    }

    public override init() {
        super.init()
    }
}
