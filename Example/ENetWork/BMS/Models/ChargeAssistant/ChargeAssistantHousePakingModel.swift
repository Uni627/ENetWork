//
//  ChargeAssistantHousePakingModel.swift
//  EServices
//
//  Created by pxy on 2020/2/16.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssistantHousePakingModel: NSObject {

    public var parkingID: String?          //车位id
    public var parkingName: String?        //车位名称
    public var parkingNum: String?         //车位号

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        parkingID = json["id"].string
        parkingName = json["parkingName"].string
        parkingNum = json["parkingNum"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if parkingID != nil {
            dictionary["id"] = parkingID
        }
        if parkingName != nil {
            dictionary["parkingName"] = parkingName
        }
        if parkingNum != nil {
            dictionary["parkingNum"] = parkingNum
        }
        return dictionary
    }
}
