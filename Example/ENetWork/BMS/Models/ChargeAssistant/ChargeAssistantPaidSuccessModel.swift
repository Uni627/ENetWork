//
//  ChargeAssistantPaidSuccessModel.swift
//  EServices
//
//  Created by pxy on 2020/3/1.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssistantPaidSuccessModel: NSObject {

    public var chargeAmount: Float?
    public var chargeCostDate: String?
    public var chargeDesc: String?
    public var chargeReceivableId: String?
    public var costTypeCode: String?
    public var costTypeName: String?
    public var feeItemID: String?
    public var ID: String?
    public var paymentID: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        chargeAmount = json["chargeAmount"].float
        chargeCostDate = json["chargeCostDate"].string
        chargeDesc = json["chargeDesc"].string
        chargeReceivableId = json["chargeReceivableId"].string
        costTypeCode = json["costTypeCode"].string
        costTypeName = json["costTypeName"].string
        feeItemID = json["feeItemId"].string
        ID = json["id"].string
        paymentID = json["paymentId"].string
    }

}
