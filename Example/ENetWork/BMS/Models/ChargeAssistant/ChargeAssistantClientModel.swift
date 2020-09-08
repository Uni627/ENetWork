//
//  ChargeAssistantClientModel.swift
//  EServices
//
//  Created by pxy on 2020/4/22.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssistantClientModel: NSObject {

    public var bank: String?
    public var bankAccount: String?
    public var bankAccountName: String?
    public var basicBatchId: String?
    public var batchId: String?
    public var birthdate: String?
    public var cellphone: String?
    public var cellphone2: String?
    public var cellphone3: String?
    public var clientType: Int?
    public var commAddress: String?
    public var companyName: String?
    public var countryId: String?
    public var credentialsNo: String?
    public var credentialsType: String?
    public var divideId: String?
    public var education: String?
    public var email: String?
    public var enabledFlag: Int?
    public var gender: String?         //"0": "男" "1": "女",  "2": "其他"
    public var hometown: String?
    public var hukouLocation: String?
    public var ID: String?
    public var isDeleted: Int?
    public var maritalState: String?
    public var mdmId: String?
    public var mdmVersion: String?
    public var name: String?
    public var nationality: String?
    public var phone: String?
    public var qq: String?
    public var remark: String?
    public var rowVersion: Int?
    public var sfGuid: String?
    public var sourceFrom: String?
    public var taxpayerIdentifyNumber: String?
    public var updateChannel: String?
    public var updationDate: Int?
    public var wbsCode: String?
    public var wechat: String?
    public var hourseID: String?
    public var relation: String?       //身份
    public var inDate: String?         //迁入日期
    public var clientId: String?       //业主Id

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        bank = json["bank"].string
        bankAccount = json["bankAccount"].string
        bankAccountName = json["bankAccountName"].string
        basicBatchId = json["basicBatchId"].string
        batchId = json["batchId"].string
        birthdate = json["birthdate"].string
        cellphone = json["cellphone"].string
        cellphone2 = json["cellphone2"].string
        cellphone3 = json["cellphone3"].string
        clientType = json["clientType"].int
        commAddress = json["commAddress"].string
        companyName = json["companyName"].string
        countryId = json["countryId"].string
        credentialsNo = json["credentialsNo"].string
        credentialsType = json["credentialsType"].string
        divideId = json["divideId"].string
        education = json["education"].string
        email = json["email"].string
        enabledFlag = json["enabledFlag"].int
        gender = json["gender"].string
        hometown = json["hometown"].string
        hukouLocation = json["hukouLocation"].string
        ID = json["id"].string
        isDeleted = json["isDeleted"].int
        maritalState = json["maritalState"].string
        mdmId = json["mdmId"].string
        mdmVersion = json["mdmVersion"].string
        name = json["name"].string
        nationality = json["nationality"].string
        phone = json["phone"].string
        qq = json["qq"].string
        remark = json["remark"].string
        rowVersion = json["rowVersion"].int
        sfGuid = json["sfGuid"].string
        sourceFrom = json["sourceFrom"].string
        taxpayerIdentifyNumber = json["taxpayerIdentifyNumber"].string
        updateChannel = json["updateChannel"].string
        updationDate = json["updationDate"].int
        wbsCode = json["wbsCode"].string
        wechat = json["wechat"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if hourseID != nil {
            dictionary["houseId"] = hourseID
        }
        if name != nil {
            dictionary["name"] = name
        }
        if relation != nil {
            dictionary["relation"] = relation
        }
        if inDate != nil {
            dictionary["inDate"] = inDate
        }
        if divideId != nil {
            dictionary["divideId"] = divideId
        }
        if cellphone != nil {
            dictionary["cellphone"] = cellphone
        }
        if gender != nil {
            dictionary["gender"] = gender
        }
        if credentialsType != nil {
            dictionary["credentialsType"] = credentialsType
        }
        if credentialsNo != nil {
            dictionary["credentialsNo"] = credentialsNo
        }
        if clientId != nil {
            dictionary["clientId"] = clientId
        }
        return dictionary
    }

    public override init() {
        super.init()
    }

}
