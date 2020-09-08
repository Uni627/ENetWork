//  房产楼栋相关
//  SendHousePropertyModel.swift
//  EServices
//
//  Created by apple on 2019/11/13.
//

import UIKit
import SwiftyJSON

public class SendHousePropertyModel: NSObject {

    public var buildingID: String? //楼栋ID
    public var unitID: String? //单元ID
    public var houseInnerName: String?
    public var code: String?
    public var checked: String?
    public var idString: String?
    public var level: String?
    public var name: String?
    public var parentID: String? //父类id

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        buildingID = json["buildingId"].string
        unitID = json["unitId"].string
        houseInnerName = json["houseInnerName"].string
        code = json["code"].string
        checked = json["checked"].string
        idString = json["idString"].string
        level = json["level"].string
        name = json["name"].string
        parentID = json["parentId"].string
    }
}
