//
//  ChargeAssistantOweListModel.swift
//  EServices
//
//  Created by pxy on 2020/2/14.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssistantOweListModel: NSObject {

    public var phone: String?
    public var feeAmount: String?
    public var houseCode: String?
    public var houseInnerName: String?
    public var houseID: String?
    public var name: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        phone = json["cellphone"].string
        feeAmount = json["feeAmount"].string
        houseCode = json["houseCode"].string
        houseInnerName = json["houseInnerName"].string
        houseID = json["houseid"].string
        name = json["name"].string
    }
}
