//
//  ChargeAssistantCheckOrderModel.swift
//  EServices
//
//  Created by pxy on 2020/2/28.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssistantCheckOrderModel: NSObject {

    public var cellPhone: String?
    public var checkCode: String?
    public var corpID: String?
    public var createTime: Int?
    public var divideID: String?
    public var divideName: String?
    public var houseID: String?
    public var houseName: String?
    public var ID: Int?
    public var isUsePoint: Int?
    public var openID: String?
    public var payAmount: Float?
    public var payDesc: String?
    public var payMethod: Int?
    public var payOrderID: String?
    public var payOrderType: String?
    public var payStatus: Int?
    public var payTime: String?
    public var paymentDetails: String?
    public var pointAccount: String?
    public var qrcodeUrl: String?
    public var trxID: String?
    public var userID: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        cellPhone = json["cellPhone"].string
        checkCode = json["checkCode"].string
        corpID = json["corpId"].string
        createTime = json["createTime"].int
        divideID = json["divideId"].string
        divideName = json["divideName"].string
        houseID = json["houseId"].string
        houseName = json["houseName"].string
        ID = json["id"].int
        isUsePoint = json["isUsePoint"].int
        openID = json["openId"].string
        payAmount = json["payAmount"].float
        payDesc = json["payDesc"].string
        payMethod = json["payMethod"].int
        payOrderID = json["payOrderId"].string
        payOrderType = json["payOrderType"].string
        payStatus = json["payStatus"].int
        payTime = json["payTime"].string
        paymentDetails = json["paymentDetails"].string
        pointAccount = json["pointAccount"].string
        qrcodeUrl = json["qrcodeUrl"].string
        trxID = json["trxid"].string
        userID = json["userId"].string
    }

    public override init() {
        super.init()
    }
}
