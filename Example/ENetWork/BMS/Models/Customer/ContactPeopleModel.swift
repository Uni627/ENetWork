//
//  ContactPeopleModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/20.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ContactPeopleModel: NSObject {

    public var bank: String?
    public var bankAccount: String?
    public var bankAccountName: String?
    public var birthDate: String?
    public var cellPhoneOne: String?          //联系电话 用这个
    public var cellPhoneTwo: String?
    public var cellPhoneThree: String?
    public var clientType: String?
    public var commAddress: String?
    public var companyName: String?
    public var corpID: String?
    public var country: String?
    public var countryID: String?
    public var createdBy: String?
    public var creationDate: String?
    public var credentialsNo: String?
    public var credentialsType: String?
    public var divideID: String?
    public var divideName: String?
    public var education: String?
    public var email: String?
    public var enabledFlag: Int?
    public var extractFrom: String?
    public var gender: String?
    public var homeTown: String?
    public var houseID: String?
    public var houseHoldLocation: String?
    public var hukouLocation: String?
    public var id: String?                         //联系人id
    public var inDate: Int?
    public var isDeleted: Int?
    public var isPropertyOwner: Int?
    public var maritalState: String?
    public var name: String?                       //联系人姓名
    public var nationality: String?
    public var outDate: String?
    public var ownerID: String?
    public var ownerNum: String?
    public var qq: String?
    public var reason: String?
    public var relation: String?                   //"relation":"PropertyOwner",
    public var remark: String?
    public var rowVersion: String?
    public var sourceFrom: String?
    public var systemCode: String?
    public var taxpayerIdentifyNumber: String?
    public var updatedBy: String?
    public var updationDate: String?
    public var wechat: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        bank = json["bank"].string
        bankAccount = json["bankAccount"].string
        bankAccountName = json["bankAccountName"].string
        birthDate = json["birthdate"].string
        cellPhoneOne = json["cellphone"].string
        cellPhoneTwo = json["cellphone2"].string
        cellPhoneThree = json["cellphone3"].string
        clientType = json["clientType"].string
        commAddress = json["commAddress"].string
        companyName = json["companyName"].string
        corpID = json["corpId"].string
        country = json["country"].string
        countryID = json["countryId"].string
        createdBy = json["createdBy"].string
        creationDate = json["creationDate"].string
        credentialsNo = json["credentialsNo"].string
        credentialsType = json["credentialsType"].string
        divideID = json["divideId"].string
        divideName = json["divideName"].string
        education = json["education"].string
        email = json["email"].string
        enabledFlag = json["enabledFlag"].int
        extractFrom = json["extractFrom"].string
        gender = json["gender"].string
        homeTown = json["homeTown"].string
        houseID = json["houseId"].string
        houseHoldLocation = json["householdLocation"].string
        hukouLocation = json["hukouLocation"].string
        id = json["id"].string
        inDate = json["inDate"].int
        isDeleted = json["isDeleted"].int
        isPropertyOwner = json["isPropertyowner"].int
        maritalState = json["maritalState"].string
        name = json["name"].string
        nationality = json["nationality"].string
        outDate = json["outDate"].string
        ownerID = json["ownerId"].string
        ownerNum = json["ownerNum"].string
        qq = json["qq"].string
        reason = json["reason"].string
        relation = json["relation"].string
        remark = json["remark"].string
        rowVersion = json["rowVersion"].string
        sourceFrom = json["sourceFrom"].string
        systemCode = json["systemCode"].string
        taxpayerIdentifyNumber = json["taxpayerIdentifyNumber"].string
        updatedBy = json["updatedBy"].string
        updationDate = json["updationDate"].string
        wechat = json["wechat"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if bank != nil {
            dictionary["bank"] = bank
        }
        if bankAccount != nil {
            dictionary["bankAccount"] = bankAccount
        }
        if bankAccountName != nil {
            dictionary["bankAccountName"] = bankAccountName
        }
        if birthDate != nil {
            dictionary["birthdate"] = birthDate
        }
        if cellPhoneOne != nil {
            dictionary["cellphone"] = cellPhoneOne
        }
        if cellPhoneTwo != nil {
            dictionary["cellphone2"] = cellPhoneTwo
        }
        if cellPhoneThree != nil {
            dictionary["cellphone3"] = cellPhoneThree
        }
        if clientType != nil {
            dictionary["clientType"] = clientType
        }
        if commAddress != nil {
            dictionary["commAddress"] = commAddress
        }
        if companyName != nil {
            dictionary["companyName"] = companyName
        }
        if corpID != nil {
            dictionary["corpId"] = corpID
        }
        if country != nil {
            dictionary["country"] = country
        }
        if countryID != nil {
            dictionary["countryId"] = countryID
        }
        if createdBy != nil {
            dictionary["createdBy"] = createdBy
        }
        if creationDate != nil {
            dictionary["creationDate"] = creationDate
        }
        if credentialsNo != nil {
            dictionary["credentialsNo"] = credentialsNo
        }
        if credentialsType != nil {
            dictionary["credentialsType"] = credentialsType
        }
        if divideID != nil {
            dictionary["divideId"] = divideID
        }
        if divideName != nil {
            dictionary["divideName"] = divideName
        }
        if education != nil {
            dictionary["education"] = education
        }
        if email != nil {
            dictionary["email"] = email
        }
        if enabledFlag != nil {
            dictionary["enabledFlag"] = enabledFlag
        }
        if extractFrom != nil {
            dictionary["extractFrom"] = extractFrom
        }
        if gender != nil {
            dictionary["gender"] = gender
        }
        if homeTown != nil {
            dictionary["homeTown"] = homeTown
        }
        if houseID != nil {
            dictionary["houseId"] = houseID
        }
        if houseHoldLocation != nil {
            dictionary["householdLocation"] = houseHoldLocation
        }
        if hukouLocation != nil {
            dictionary["hukouLocation"] = hukouLocation
        }
        if id != nil {
            dictionary["id"] = id
        }
        if inDate != nil {
            dictionary["inDate"] = inDate
        }
        if isDeleted != nil {
            dictionary["isDeleted"] = isDeleted
        }
        if isPropertyOwner != nil {
            dictionary["isPropertyowner"] = isPropertyOwner
        }
        if maritalState != nil {
            dictionary["maritalState"] = maritalState
        }
        if name != nil {
            dictionary["name"] = name
        }
        if nationality != nil {
            dictionary["nationality"] = nationality
        }
        if outDate != nil {
            dictionary["outDate"] = outDate
        }
        if ownerID != nil {
            dictionary["ownerId"] = ownerID
        }
        if ownerNum != nil {
            dictionary["ownerNum"] = ownerNum
        }
        if qq != nil {
            dictionary["qq"] = qq
        }
        if reason != nil {
            dictionary["reason"] = reason
        }
        if relation != nil {
            dictionary["relation"] = relation
        }
        if remark != nil {
            dictionary["remark"] = remark
        }
        if rowVersion != nil {
            dictionary["rowVersion"] = rowVersion
        }
        if sourceFrom != nil {
            dictionary["sourceFrom"] = sourceFrom
        }
        if systemCode != nil {
            dictionary["systemCode"] = systemCode
        }
        if taxpayerIdentifyNumber != nil {
            dictionary["taxpayerIdentifyNumber"] = taxpayerIdentifyNumber
        }
        if updatedBy != nil {
            dictionary["updatedBy"] = updatedBy
        }
        if updationDate != nil {
            dictionary["updationDate"] = updationDate
        }
        if wechat != nil {
            dictionary["wechat"] = wechat
        }
        return dictionary
    }

}
