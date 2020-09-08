//
//  ChargeAssistantArrearsDetailModel.swift
//  EServices
//
//  Created by pxy on 2020/2/16.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssistantArrearsDetailModel: NSObject {

    public var feeList: [ArrearsFee] = []

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        if let feeListArray = json["feeList"].array {
            for feeListJson in feeListArray {
                let value = ArrearsFee(fromJson: feeListJson)
                feeList.append(value)
            }
        }
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        var dictionaryElements = [[String: Any]]()
        for feeListElement in feeList {
            dictionaryElements.append(feeListElement.toDictionary())
        }
        dictionary["feeList"] = dictionaryElements
        return dictionary
    }
}

public class ArrearsFee: NSObject, NSMutableCopying {
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        return self
    }

    public var arrearsLevel: Int?   //欠费等级 1:往年欠费；2:当年欠费；3:无欠费
    public var buildingID: String?
    public var buildingName: String?
    public var feeAmount: Double = 0.0
    public var feeTotal: Double = 0.0
    public var houseID: String?
    public var houseTotal: Int?
    public var feeHouseTotal: Int?
    public var type: Int?              //1:楼幢；2:单元3:房号
    public var unitID: String?
    public var unitName: String?
    public var name: String?
    public var houseName: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        arrearsLevel = json["arrearsLevel"].int
        buildingID = json["buildingId"].string
        feeAmount = json["feeAmount"].double ?? 0.0
        feeTotal = json["feeTotal"].double ?? 0.0
        houseID = json["houseId"].string
        name = json["name"].string
        houseTotal = json["houseTotal"].int
        feeHouseTotal = json["feeHouseTotal"].int
        type = json["type"].int
        unitID = json["unitId"].string
        houseName = json["name"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if arrearsLevel != nil {
            dictionary["arrearsLevel"] = arrearsLevel
        }
        if buildingID != nil {
            dictionary["buildingId"] = buildingID
        }
        dictionary["feeAmount"] = feeAmount
        dictionary["feeTotal"] = feeTotal
        if houseID != nil {
            dictionary["houseId"] = houseID
        }
        if houseTotal != nil {
            dictionary["houseTotal"] = houseTotal
        }
        if feeHouseTotal != nil {
            dictionary["feeHouseTotal"] = houseTotal
        }
        if type != nil {
            dictionary["type"] = type
        }
        if unitID != nil {
            dictionary["unitId"] = unitID
        }
        return dictionary
    }

    public override init() {
        super.init()
    }
}
