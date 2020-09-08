//
//  ChargeAssistantPayDetailModel.swift
//  EServices
//
//  Created by pxy on 2020/2/16.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssistantPayDetailModel: NSObject {

    public var acct: String?                       //支付人帐号:例如:微信支付的openid
    public var appID: String?                      //应用ID：通联支付平台分配的APPID
    public var cellPhone: String?                  //积分缴费时手机号
    public var checkCode: String?                  //积分缴费短信验证码
    public var channelTransactionID: String?       //渠道交易单号:如支付宝,微信平台订单号
    public var corpID: String?
    public var cusID: String?                      //商户ID：通联支付平台分配的商户号
    public var cusorderID: String?                 //商户订单号
    public var divideID: String?                   //分期id
    public var houseID: String?
    public var houseName: String?
    public var orderType: String?                  //支付业务类型: pty-101：物业缴费；pty-102：物业预缴费
    public var type: String?                       //缴费方式（选项：A01支付宝，A02微信，A03银联)
    public var paymentID: String?
    public var paymentList: [PaymentItem] = []     //付款明细
    public var paytime: String?                    //交易完成日期：yyyyMMddHHmmss
    public var sign: String?                       //签名
    public var transactionAmount: String?          //交易金额（以分为单位）
    public var transactionCode: String?            //交易类型：VSP511 : 支付宝支付
    public var transactionDate: String?            //交易请求日期：yyyyMMdd
    public var transactionID: String?              //账单流水号，通联内唯一，用于查询账单
    public var transactionReserved: String?        //缴费说明
    public var transactionStatus: String?          //交易状态：0000:交易成功；3045:交易超时；
    public var userName: String?                   //用户名称
    public var userID: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        acct = json["acct"].string
        appID = json["appid"].string
        cellPhone = json["cellPhone"].string
        checkCode = json["checkCode"].string
        channelTransactionID = json["chnltrxid"].string
        corpID = json["corpId"].string
        cusID = json["cusid"].string
        cusorderID = json["cusorderid"].string
        divideID = json["divideId"].string
        houseID = json["houseId"].string
        houseName = json["houseName"].string
        orderType = json["pOrderType"].string
        type = json["pType"].string
        paymentID = json["paymentId"].string
        paymentList = [PaymentItem]()
        let paymentListArray = json["paymentList"].arrayValue
        for paymentListJson in paymentListArray {
            let value = PaymentItem(fromJson: paymentListJson)
            paymentList.append(value)
        }
        paytime = json["paytime"].string
        sign = json["sign"].string
        transactionAmount = json["trxamt"].string
        transactionCode = json["trxcode"].string
        transactionDate = json["trxdate"].string
        transactionID = json["trxid"].string
        transactionReserved = json["trxreserved"].string
        transactionStatus = json["trxstatus"].string
        userName = json["userName"].string
        userID = json["userid"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if acct != nil {
            dictionary["acct"] = acct
        }
        if appID != nil {
            dictionary["appid"] = appID
        }
        if cellPhone != nil {
            dictionary["cellPhone"] = cellPhone
        }
        if checkCode != nil {
            dictionary["checkCode"] = checkCode
        }
        if channelTransactionID != nil {
            dictionary["chnltrxid"] = channelTransactionID
        }
        if corpID != nil {
            dictionary["corpId"] = corpID
        }
        if cusID != nil {
            dictionary["cusid"] = cusID
        }
        if cusorderID != nil {
            dictionary["cusorderid"] = cusorderID
        }
        if divideID != nil {
            dictionary["divideId"] = divideID
        }
        if houseID != nil {
            dictionary["houseId"] = houseID
        }
        if houseName != nil {
            dictionary["houseName"] = houseName
        }
        if orderType != nil {
            dictionary["pOrderType"] = orderType
        }
        if type != nil {
            dictionary["pType"] = type
        }
        if paymentID != nil {
            dictionary["paymentId"] = paymentID
        }
        var dictionaryElements = [[String: Any]]()
        for paymentListElement in paymentList {
            dictionaryElements.append(paymentListElement.toDictionary())
        }
        dictionary["paymentList"] = dictionaryElements
        if paytime != nil {
            dictionary["paytime"] = paytime
        }
        if sign != nil {
            dictionary["sign"] = sign
        }
        if transactionAmount != nil {
            dictionary["trxamt"] = transactionAmount
        }
        if transactionCode != nil {
            dictionary["trxcode"] = transactionCode
        }
        if transactionDate != nil {
            dictionary["trxdate"] = transactionDate
        }
        if transactionID != nil {
            dictionary["trxid"] = transactionID
        }
        if transactionReserved != nil {
            dictionary["trxreserved"] = transactionReserved
        }
        if transactionStatus != nil {
            dictionary["trxstatus"] = transactionStatus
        }
        if userName != nil {
            dictionary["userName"] = userName
        }
        if userID != nil {
            dictionary["userid"] = userID
        }
        return dictionary
    }
}

public class PaymentItem: NSObject {

    public var remark: String?                     //账单说明
    public var parkingID: String?                  //车位id
    public var receivableID: String?               //物业应收id
    public var totalReceivableAmount: String?      //付款金额

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        remark = json["bRemark"].string
        parkingID = json["parkingId"].string
        receivableID = json["receivableId"].string
        totalReceivableAmount = json["totalReceivableAmount"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if remark != nil {
            dictionary["bRemark"] = remark
        }
        if parkingID != nil {
            dictionary["parkingId"] = parkingID
        }
        if receivableID != nil {
            dictionary["receivableId"] = receivableID
        }
        if totalReceivableAmount != nil {
            dictionary["totalReceivableAmount"] = totalReceivableAmount
        }
        return dictionary
    }
}
