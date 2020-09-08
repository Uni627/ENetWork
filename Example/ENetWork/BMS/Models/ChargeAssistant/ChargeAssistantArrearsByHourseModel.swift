//
//  ChargeAssistantArrearsByHourseModel.swift
//  EServices
//
//  Created by pxy on 2020/2/16.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

public class ChargeAssistantArrearsByHourseModel: NSObject {

    public var arrearsMonth: String?
    public var arrearsNum: Int?
    public var clientName: String?
    public var clientPhone: String?
    public var feeAmount: Double = 0.0
    public var houseInnerName: String?
    public var houseID: String?
    public var clientID: String?
    public var urgeList: [UrgeModel] = []
    public var hasTags  = false

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        arrearsMonth = json["arrearsMonth"].string
        arrearsNum = json["arrearsNum"].int
        clientName = json["clientName"].string
        clientPhone = json["clientPhone"].string
        feeAmount = json["feeAmount"].double ?? 0.0
        houseInnerName = json["houseInnerName"].string
        houseID = json["houseId"].string
        clientID = json["clientId"].string
        urgeList = [UrgeModel]()
        let urgeListArray = json["urgeList"].arrayValue
        for urgeListJson in urgeListArray {
            let value = UrgeModel(fromJson: urgeListJson)
            urgeList.append(value)
        }
    }
}

public class UrgeModel: NSObject {

    public var remark: String?
    public var urgeDate: String?
    public var type: Int?          //0系统催缴；1线下催缴
    public var user: String?
    public var height: CGFloat?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        remark = json["remark"].string
        urgeDate = json["urgeDate"].string
        type = json["type"].int
        user = json["user"].string
    }
}
