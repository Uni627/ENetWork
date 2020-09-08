//
//  ChargeAssisitantPaidListModel.swift
//  EServices
//
//  Created by pxy on 2020/2/16.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssisitantPaidListModel: NSObject {

    public var houseId: String?
    public var houseName: String?                  //房源名称
    public var paymentOrder: [PaymentOrder] = []   //实收订单列表

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        houseId = json["houseId"].string
        houseName = json["houseName"].string
        paymentOrder = [PaymentOrder]()
        let paymentOrderArray = json["paymentOrder"].arrayValue
        for paymentOrderJson in paymentOrderArray {
            let value = PaymentOrder(fromJson: paymentOrderJson)
            paymentOrder.append(value)
        }
    }
}

public class PaymentOrder: NSObject {

    public var externalSysPayCode: String?     //外部系统支付编号(如通联支付流水号)
    public var money: String?                  //缴费金额
    public var type: String?                   //缴费方式编码
    public var typeName: String?
    public var paymentList: [PaymentList] = []
    public var paytime: String?                //缴费日期
    public var serialNum: String?              //收费系统内部编号
    public var trxdate: String?
    public var userName: String?
    public var userID: String?                 //用户的SFID

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        externalSysPayCode = json["external_sys_pay_code"].string
        money = json["pMoney"].string
        type = json["pType"].string
        typeName = json["pTypeName"].string
        paymentList = [PaymentList]()
        let paymentListArray = json["paymentList"].arrayValue
        for paymentListJson in paymentListArray {
            let value = PaymentList(fromJson: paymentListJson)
            paymentList.append(value)
        }
        paytime = json["paytime"].string
        serialNum = json["serial_num"].string
        trxdate = json["trxdate"].string
        userName = json["userName"].string
        userID = json["userid"].string
    }
}

public class PaymentList: NSObject {

    public var chargeTypeCode: String?
    public var chargeTypeName: String?
    public var costDateCourse: String?
    public var costTypeCode: String?
    public var costTypeName: String?
    public var paidMoney: String?
    public var receivableID: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        chargeTypeCode = json["chargeTypeCode"].string
        chargeTypeName = json["chargeTypeName"].string
        costDateCourse = json["costDateCourse"].string
        costTypeCode = json["costTypeCode"].string
        costTypeName = json["costTypeName"].string
        paidMoney = json["paidMoney"].string
        receivableID = json["receivableId"].string
    }
}
