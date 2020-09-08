//
//  ChargeAssisitantOweDetailModel.swift
//  EServices
//
//  Created by pxy on 2020/2/15.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssisitantOweDetailModel: NSObject {

    public var clientName: String?
    public var feeArea: Float?
    public var houseID: String?
    public var paymentList: [ChargeAssistantPaymentList] = []
    public var totalPage: Int?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        clientName = json["clientName"].string
        feeArea = json["feeArea"].float
        houseID = json["houseId"].string
        paymentList = [ChargeAssistantPaymentList]()
        let paymentListArray = json["paymentList"].arrayValue
        for paymentListJson in paymentListArray {
            let value = ChargeAssistantPaymentList(fromJson: paymentListJson)
            paymentList.append(value)
        }
        totalPage = json["totalPage"].int
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if clientName != nil {
            dictionary["clientName"] = clientName
        }
        if feeArea != nil {
            dictionary["feeArea"] = feeArea
        }
        if houseID != nil {
            dictionary["houseId"] = houseID
        }
        if totalPage != nil {
            dictionary["totalPage"] = totalPage
        }
        return dictionary
    }

    public override init() {
        super.init()
    }
}

public class ChargeAssistantPaymentList: NSObject {

    public var list: [ChargeAssistantPaymentChildList] = []    //物业应收列表（未付款）
    public var chargeTypeCode: String?  //1水费  2车位费  3其他  4物业费  5电费
    public var chargeTypeName: String?
    public var feeItemCode: String?
    public var feeItemName: String?
    public var parkingNum: String?
    public var feeTotal: Float?
    public var showAll = false
    public var selectAll = true

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        chargeTypeCode = json["chargeTypeCode"].string
        chargeTypeName = json["chargeTypeName"].string
        feeItemCode = json["feeItemCode"].string
        feeItemName = json["feeItemName"].string
        feeTotal = json["feeTotal"].float
        parkingNum = json["parkingNum"].string
        list = [ChargeAssistantPaymentChildList]()
        let listArray = json["list"].arrayValue
        for listJson in listArray {
            let value = ChargeAssistantPaymentChildList(fromJson: listJson, typeCode: chargeTypeCode)
            list.append(value)
        }
    }

    public override init() {
        super.init()
    }
}

public class ChargeAssistantPaymentChildList: NSObject {

    public var chargeTypeCode: String?
    public var adjustMoney: String?
    public var billDate: String?
    public var breakMoney: String?
    public var costDateCourse: String?
    public var cycleEndDate: Int?
    public var cycleStartDate: Int?
    public var isInvoice: String?
    public var isRecepit: String?
    public var month: String?
    public var nationalCode: String?
    public var paidMoney: String?
    public var productCode: String?
    public var receivableAmount: Double?
    public var receivableId: String?
    public var remark: String?
    public var status: String?
    public var taxRate: String?
    public var totalReceivableAmount: Double = 0.0
    public var yearMonth: String?
    public var parkingNum: String?
    public var selected = true

    init(fromJson json: JSON!, typeCode: String?) {
        super.init()
        if json.isEmpty {
            return
        }
        chargeTypeCode = typeCode
        adjustMoney = json["adjustMoney"].string
        billDate = json["billDate"].string
        breakMoney = json["breakMoney"].string
        costDateCourse = json["costDateCourse"].string
        cycleEndDate = json["cycleEndDate"].int
        cycleStartDate = json["cycleStartDate"].int
        isInvoice = json["isInvoice"].string
        isRecepit = json["isRecepit"].string
        month = json["month"].string
        nationalCode = json["nationalCode"].string
        paidMoney = json["paidMoney"].string
        productCode = json["productCode"].string
        receivableAmount = json["receivableAmount"].double
        receivableId = json["receivableId"].string
        remark = json["remark"].string
        status = json["status"].string
        taxRate = json["taxRate"].string
        totalReceivableAmount = json["totalReceivableAmount"].double ?? 0.0
        totalReceivableAmount = totalReceivableAmount.roundTo(places: 2)
        yearMonth = json["yearMonth"].string
        parkingNum = json["parkingNum"].string
    }

    public override init() {
        super.init()
    }
}
