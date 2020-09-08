//
//  ChargeAssisitantAdvanceListModel.swift
//  EServices
//
//  Created by pxy on 2020/2/16.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssisitantAdvanceListModel: NSObject {

    public var feeIAttribute: String?      //预缴项目类型 1:水费,2:车位服务费,3:临时收费,4:物业服务费,5:电费,6:押金,
    public var feeItemId: String?
    public var feeItemName: String?
    public var parkingId: String?
    public var parkingName: String?
    public var parkingNum: String?
    public var residueAmount: Double = 0.0
    public var unitPrice: Double = 0.0
    public var totalMoney: Double = 0.0
    public var clientName: String?
    public var month: Int = 1
    public var selected = true

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        feeIAttribute = json["feeIAttribute"].string
        feeItemId = json["feeItemId"].string
        feeItemName = json["feeItemName"].string
        parkingId = json["parkingId"].string
        parkingName = json["parkingName"].string
        parkingNum = json["parkingNum"].string
        clientName = json["clientName"].string
        residueAmount = json["residueAmount"].double ?? 0.0
        residueAmount = residueAmount.roundTo(places: 2)
        unitPrice = json["unitPrice"].double ?? 0.0
        totalMoney = unitPrice.roundTo(places: 2)

    }
    public override init() {
        super.init()
    }

}
