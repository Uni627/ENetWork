//
//  ChargeAssistantHouseModel.swift
//  EServices
//
//  Created by pxy on 2020/2/14.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssistantHouseModel: NSObject {

    public var houseCode: String?
    public var houseInnerName: String?
    public var id: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        houseCode = json["houseCode"].string
        houseInnerName = json["houseInnerName"].string
        id = json["id"].string
    }
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if houseCode != nil {
            dictionary["houseCode"] = houseCode
        }
        if houseInnerName != nil {
            dictionary["houseInnerName"] = houseInnerName
        }
        if id != nil {
            dictionary["id"] = id
        }
        return dictionary
    }
}

public class ChargeAssistantBuildingModel: NSObject {
    public var divideId: String?
    public var buildingName: String?
    public var unitCode: String?

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if divideId != nil {
            dictionary["divideId"] = divideId
        }
        if buildingName != nil {
            dictionary["buildingName"] = buildingName
        }
        if unitCode != nil {
            dictionary["unitCode"] = unitCode
        }
        return dictionary
    }
}
